Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA8B80020B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377100AbjLADXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjLADXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:23:23 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568CE12A;
        Thu, 30 Nov 2023 19:23:29 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B12ipTW008401;
        Thu, 30 Nov 2023 19:22:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfptdkimsnps;
 bh=t9UK/YuaatAD7BOEji2o+Gatjt/ucwUWcirntcShbPk=;
 b=lZJ2v+Rr9+pk1AFqeRCPEv6gsByeY9f3WPq0ye0zZUHhMTIkhqDzO4eXPmDm1p14QgJS
 HW14q8xugqZLr5eLpkQZN1fqbtPUKguo8GMv/zTbVLqPg989PNIoz+St4GZ+Yc1QMyhi
 vQfIchYktaN5s6jGiEkyfDZSi8JHFK6o55lo+HJu4Rf4KSHq7Nvt+YKKfj/nUfGxMEdM
 oR8U8EWoG/dqyvJrEI4vgg3Lfy2GFKXwZrQVGxOlM43L2+pAqIE74Om46FDwJqG7rTrW
 96taF2uIsrOIg2OCyEr62qY22PtrcKUiS/2j/NO63iKSEpVK1y/L3pynH22exbTOvHYc 0A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ukgr025wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 19:22:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1701400934; bh=iiqd//YRmd6vHZ8cR1yeAPqfPqGcRWfqILP+m/ka8No=;
        h=From:To:CC:Subject:Date:From;
        b=IJH3RYtyB56mJhHtmYXTYuqqRzOgOpChw+BeF0ogC4NrZahF6scj87qrH/ePscavN
         lmGz5KFm6t6KcCBR8nx0cnn42ixeBYohyEN0mFJbNOEZPSCHu69gSJEeMA61c/VBGd
         6VmhV5BnDyRohz1z+9aluXcBk5q++VX7Dj5guYCUur9Ky+dVh9U1brODDnL1RVJsjQ
         /Yin0/bS6fhQzfJpdhhgIGHHWtRASr0sfhhzv2gUxpes+LdukPsXxvbaJYqLOtE4du
         s6a/g8Zwwt1vp0WjQXPdTbmXSOKBOj20gMZ/PIKanK6QWro+TAplwIGqQ/IzaRBzAa
         op8oDEgPJ1mUA==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5522040541;
        Fri,  1 Dec 2023 03:22:11 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 241E3A0109;
        Fri,  1 Dec 2023 03:22:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rWTdNjaC;
        dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7FAEB4029A;
        Fri,  1 Dec 2023 03:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKBIR6uA5aud8UoKoi83DtDJnfm9n6P/vro7Ym7pmZUFBlWPQgd4kF5awRIfMNEycTXsmLl2uMd4ML0YUr0t4pJUuYwxOQcZZuwhdKxGdfHk9g8Jcqeg6aGku6ysFJbUzqWzcbFXMOvZ1MW6rGwxmNvt1UsVOQAOUUfOvg8FLSRGLkZMvs0wu+p/PgN5pylDGk/aVPi3I70w47Rh4iyamf/ATm0DyZZRe/js4Eie4RijBdLRTQoAyJLOYT2Nc+fRR3I55JbjJIeV8GJqx65+b/Nb/phxRkD8oAUo3ubeITAO6kAasC81meGRLsC4UzWpnzekbj1Atm2jc2CYyzYlmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9UK/YuaatAD7BOEji2o+Gatjt/ucwUWcirntcShbPk=;
 b=fzRd3f8FqoFS4I1Rqo271wHEi9yavUc7QMATxJ6u7ojKP6Z235bGuAUFk6KkELh2NoqKFwY0FO5kQoLi2VCcnEHbnqMsGi+QeCnC6VLH5pe/kykU0jSigZys69mX03/sjVpug2N3BcB6zplvxMSZN44b06zQ2bXEIAPjDfI3sObljdpM+vE7y50QOGUpEYekPpcDNDCtJlpJElTY9UpXSKL7xBGm9RxQa1A4Dfa2rpq7XLzgwfk0CdKhOdJR4FrU51rqks9kzdZE9sTSbPHu9W+M/1wu7iVCCML06k+14AkIMvZxjtpTqE/cCyf9Tohimd0I94ySZbQlm082m4bKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9UK/YuaatAD7BOEji2o+Gatjt/ucwUWcirntcShbPk=;
 b=rWTdNjaC7melES6VSMV71We1NI9HXQZkYx6j+GCLL2UUr6+hOTkoXYgr42JjQJL194DcrWH4tNwSGfWf0Dj3WXOTpJwTxTVZ+FdCvR6bAJ2Xn/BUFYB3iocSMDLj3KvpOPclBPyv92Eu0cxgaqoYINKFJR6IKds+16WPgGbbrlM=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.22; Fri, 1 Dec 2023 03:22:03 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7046.023; Fri, 1 Dec 2023
 03:22:03 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Johannes Zink <j.zink@pengutronix.de>,
        "Russell King (Oracle" <rmk+kernel@armlinux.org.uk>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
CC:     "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] net: stmmac: fix FPE events losing
Thread-Topic: [PATCH v4] net: stmmac: fix FPE events losing
Thread-Index: AdokASEt2MUHajyZQVChZDLmS+c6pw==
Date:   Fri, 1 Dec 2023 03:22:03 +0000
Message-ID: <CY5PR12MB637225A7CF529D5BE0FBE59CBF81A@CY5PR12MB6372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|DS0PR12MB7803:EE_
x-ms-office365-filtering-correlation-id: f6635fed-4329-4b9c-96e5-08dbf21cb035
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jmy5Xxy9HDBhSU9p9z9k2ntv4Goq/ydaBC5A6+1hvl7douidVT1X/dkaBbcbkBN1nQphnhXAHMiusTgmErbKdYNr3KR7C/JaCjNYrbIBbtUnCRXph77trQT2AhzV1kHwoXd4rs0RJGM5J9eJzl2ePhsWiCIwwvkvP7fpl/oc54+lLl/QqLckL9UNsow2Jbh8rV6KHNx1VIUGLzognE+I3F4YTJ5/n6yQoZdnGTLWcAmumhhYSJakkf4hhpcZvTuTSMGLBuCSrxqT3t6IgAhby/nwHvpOFLyDKDz+r1ZUKvdLGAUgYQtLjQ6XpnyJClIPby24GJqLj3JrH6QRM0ZFEqFesTCojEYaDPoSyrO9n1/44CV477WVeXj2wonz4IIkqSfZG/auGq/AVlSmPLj/6vU667rEYlOIXMWDaAPUwPNJIJnpCivVrps/L59Ea0ykcznrj83/dfZkqENEImSJaBDwsSfqqw7e2n4zSCXS1RHaj/HK06ThgukLr4UIlU560uXK4DHqDJ2m4t05zYXTgmMgxwCCwK+ityyYeM3NE9X6n2PpaFsGkK4+GkUHtHveDF6e76VJVahq1zzh0Rp2+OkJa9Xrst5IMnPPA3d28rgddS5TOSpZNI9K17hvdE52DXXg3LKyyXnde0KFVh8L5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(6506007)(7696005)(71200400001)(86362001)(64756008)(54906003)(66476007)(55016003)(110136005)(66946007)(66446008)(66556008)(6636002)(26005)(76116006)(316002)(8676002)(4326008)(8936002)(478600001)(9686003)(52536014)(7416002)(38100700002)(5660300002)(122000001)(2906002)(921008)(41300700001)(38070700009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ntMcQhDtK+BndCrjtR5mZbNJ2uez4nnmXW+CycNWjYPWx8qrHeTb23BpgwYk?=
 =?us-ascii?Q?1n50y2P3LXvy6QvkaMW2Y89UgCnGAeW5DcAR4ZL2etdQctUFRQv/BAGx38eA?=
 =?us-ascii?Q?7GPoGUTm3cHyyGu1qm+j93YSyf7gOcccyuefTXsu13GsWGJfKdP76FSrCDkJ?=
 =?us-ascii?Q?F+OOXw9vHnm6ETfYrllLvDSlOoc+cW8OOeDun1eu87lg/4QwEx6fwVUrOtRp?=
 =?us-ascii?Q?BszAZPJlhk0nr9tDNE0CuAuL7+unEpNrIFt8LU+gMRvnrpDvfg9PNCFvlis3?=
 =?us-ascii?Q?aC1/zclCg7AOAe76OrfVB/91lYsW8hZCZLzPcGQ4pZu61LZKVW+jFZXPagwD?=
 =?us-ascii?Q?bAtLQZ8kUcg0R4GJnxO3+Fl7BIC908CZlyrRT1kSX4agb3XPCCa/1NX8MbbD?=
 =?us-ascii?Q?jTK/53LGA25Zbnnw0k7AXjgsSHPeCRO6Y2FzNSjvDhO85GqypL1kIZfKpym/?=
 =?us-ascii?Q?YVAKZxtAffdsmHOxmVbcSDP3rafCbZGcUZ2GDtJNpxN7szA0/P/wr8x9kOwL?=
 =?us-ascii?Q?RKP1cHnuS5MixW4cqUcxXun9CjpRoFKpBpw8VwSjt4CWhtKKW897EqpJwc4x?=
 =?us-ascii?Q?Pp0Xfu1N1wx94OfsT3lgnvAlWtSKN7RPa9EiNBHRCaZZ0EhI4NyFy0gV8a+X?=
 =?us-ascii?Q?Zw+gLTcYP+G9uxMv4n2Vi3W/8FDANERM91yjsUgtLO4ukMJgRFUKduSZL+FJ?=
 =?us-ascii?Q?g6+F6XQA6UKCqq3EKQ45UFVWJO5q4Uoz+EjbbPrMdJLWueIA4M0VzE0vnTdh?=
 =?us-ascii?Q?Bw71+XrVmLshDhGP9bD+eckn/2N4H0GL2ju5lFdewhkJLx8APUCAkz1lefhy?=
 =?us-ascii?Q?oQAgHSUeX/2kzYh7OatFBpJiHQRcHAXTXt/+1T8W++0UDcy2ixymLSNU4zE3?=
 =?us-ascii?Q?nRv+h+CecgeiKaJ38/u4aPTRL3fAmppMLqU70LmySyDTmMHAudQulspN/fq1?=
 =?us-ascii?Q?6X2+lBGHZtm/9Bnl0hRjbxClgEegfp+hY+TzS7A+OyWKJKwDEDVq8hvv5PU8?=
 =?us-ascii?Q?b8OXFeb2dRYWvLs5At8SyaFzicUv4mKeh3q41ML4OiPV6UyuOsgCz5E4hbJb?=
 =?us-ascii?Q?ZkuRDhfaHH90Yzy+1ugZliD6jGIF0ZFTLUaaHSKBtX3q5iEC8N2USyMK6CJW?=
 =?us-ascii?Q?F9nEcd2RnzDO2hJl1aZNYwGLr7yZsEHziyscsHQePkqFMJPT97p9R3wWlbNI?=
 =?us-ascii?Q?Jwlvkk4Aa0YWt+Fv+ZPalZ/PFEVLcBMOUD0Kk4kiWTutRc4+QAfjRFefXd56?=
 =?us-ascii?Q?T7ntG4bP4fI7JJnGkPjxKOwabUf3QBXS+gu0oYoGOjj+4mBOwepYjxk+XFVM?=
 =?us-ascii?Q?EYh8Y8pMH03lxV2ThJUGc6sLjnDIP0hRaDVEv9w+1x774lLYKSW69urOnLHY?=
 =?us-ascii?Q?o5Q89/RslYvlQYg9XRIXCr8qNauYSuJKVVR2x2mhZ3Zi86HVBbxDW/wv/710?=
 =?us-ascii?Q?H/z8RHzsS9/JMBT0EqUpibMXgncjkt2SOqaxM/mbB0VBxT69MqeKIvSHC0Ga?=
 =?us-ascii?Q?x8rFptRVZWriZq5F9RLTadCbo1ctQrY7W9Q24XKZwixWDYLjpy3kMd3VrZKP?=
 =?us-ascii?Q?+h0e44lrOrD7zpbVnt24DoGbO3m7gubKkUBeQD2T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VXbTI0TSiKU9djBPz0d1LEx+cfRNj5SVx4QxQYiyEtDAz3VbCfpw9bcsL2N6?=
 =?us-ascii?Q?pzRJqMYjbnH1QrlQHbfP8VQhg1421+78/jTxmblVQvwIFmyF2Hh8pKfj2yAw?=
 =?us-ascii?Q?kv7JcEe9+manOH7tISro+YDBRgdXMfnRg9KZil4/OZdfVSOclFT+aTw2TJSk?=
 =?us-ascii?Q?VawgP43HB/DGCmhkCaiSrjjAjSS4QQA5WvHMCf6rVFHUW3JfuSkDrrkfIfUf?=
 =?us-ascii?Q?2MUrysBLHJF8W9n1N1+iEdYiQLquibYYpnO9mOz94tiV5xIWBQDLzqPIHubB?=
 =?us-ascii?Q?h4gxpX12Azoa5PLbl7lZS3CmpKg+/gj2djL4205O/VdFuBETO8yWY9Hnpl+t?=
 =?us-ascii?Q?TrkeCDqN7l3TiSejK3tuLT21N6404orH+0JZB/klSBKu7SkWfulYyDhklkEg?=
 =?us-ascii?Q?qdhbSi0MMHKnn0xBtfqgM7oeibgOjSzKO3BoXuFM6pe0pkFsK7SWSLajQJAE?=
 =?us-ascii?Q?jXXOeWOBHcNDZkLPpP0T9C+B7RchP8316vfKuvsFhCOIYO/CygB3R2+wsM9D?=
 =?us-ascii?Q?wdql2vO70KsAlCyguOQCINYnSgqixS+jy4aQSaT3F0R1lDHDe64LTE8uSEOw?=
 =?us-ascii?Q?qwO5M6zwPO84REyG/UMgRkgVN9uecd1WmHKCjxcFwn3UqIRW/HYbJVh5i95y?=
 =?us-ascii?Q?4e+rP0jJ0cheuP5AWJW36jB/DijH6EJQMUOiw+Vzg+8JzXpB5Ax09OTj2Qpg?=
 =?us-ascii?Q?hCTDUfpktIHl3Hnrbs054M/51YXafUUCTzGyHeMRkCQIU3qisAosN/+JIZD+?=
 =?us-ascii?Q?5XcdES44dO83fhg1zLgBtdEtWtI1tTmLobkCmtB5uZy+gm7e88d+Mo6lv+vv?=
 =?us-ascii?Q?uBVh/b/cGVJm1P1rVMMRCiZ/L/U9kn+jbeUoG+IW7AGwbVfBzEHF4+IKXHnv?=
 =?us-ascii?Q?8aTy4gCETe3lZlbKB+W+RMmgLg75gchLEE8+a10bt1nTrWmvGvUlPf4n//Q+?=
 =?us-ascii?Q?jsRSzyaToBd+OnLNNrqsyyXVyX78wu8Xnp8BwNqmv9+6x/0DDcw2TaYH8Ysw?=
 =?us-ascii?Q?KWgJY7sZxIC7rVM0eTBuwBM90vWS777JqH+IwQ5voLvJ/KKkK1SYnB6VIByz?=
 =?us-ascii?Q?ONApJZsyno4kNoWOzKoHazioaRFPBg04F8ZFckwfmXW7i5uc190SO1j951M8?=
 =?us-ascii?Q?JN7xIAVsNM6kf+L8ir5HU4tLjmUQJx0YXo36+0rkAz95JNouhvF8W6ZIrSJQ?=
 =?us-ascii?Q?zfAkBwPNEiOhGCxZsc/mFIBr39HXIPyLqs4j3JdfRYEhXdwS8z6fYLr4MyDf?=
 =?us-ascii?Q?rfKhqnmtJ/IvuitV/2+sgSkOszST2kFlMvHLNtnLfoHu1xq2ryDsS5GpftnJ?=
 =?us-ascii?Q?uSKGrQz1I6pvKTYm+iM59eWeFaXBbyzT8ysfcbWWCNZpjw=3D=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6635fed-4329-4b9c-96e5-08dbf21cb035
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 03:22:03.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sG6ngtKJordscrt1mHKiKsh+wm+ETY1x+ZvkdKBmaMQoUQMk1w1tSrVna7INjcJqVNACXJhBD43lHCiF8isSxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
X-Proofpoint-ORIG-GUID: oKbYXadeAtlUoQ62DuyBUC40D3fkqPGj
X-Proofpoint-GUID: oKbYXadeAtlUoQ62DuyBUC40D3fkqPGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_25,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 bulkscore=0 mlxlogscore=877 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 phishscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status bits of register MAC_FPE_CTRL_STS are clear on read. Using
32-bit read for MAC_FPE_CTRL_STS in dwmac5_fpe_configure() and
dwmac5_fpe_send_mpacket() clear the status bits. Then the stmmac interrupt
handler missing FPE event status and leads to FPE handshaking failure and
retries.
To avoid clear status bits of MAC_FPE_CTRL_STS in dwmac5_fpe_configure()
and dwmac5_fpe_send_mpacket(), add fpe_csr to stmmac_fpe_cfg structure to
cache the control bits of MAC_FPE_CTRL_STS and to avoid reading
MAC_FPE_CTRL_STS in those methods.

Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shaking pr=
ocedure")
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Jianheng Zhang <Jianheng.Zhang@synopsys.com>
---
v1 -> v2:
   Refactor patch to avoid using readb().
V2 -> v3:
   Fix Signed-off-by tag name.
V3 -> v4:
   Fix Signed-off-by tag email address.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 45 +++++++++---------=
----
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |  4 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  3 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  8 +++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  1 +
 include/linux/stmmac.h                             |  1 +
 7 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/eth=
ernet/stmicro/stmmac/dwmac5.c
index e95d35f..8fd1675 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -710,28 +710,22 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, stru=
ct net_device *dev,
 	}
 }
=20
-void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg=
,
+			  u32 num_txq, u32 num_rxq,
 			  bool enable)
 {
 	u32 value;
=20
-	if (!enable) {
-		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
-
-		value &=3D ~EFPE;
-
-		writel(value, ioaddr + MAC_FPE_CTRL_STS);
-		return;
+	if (enable) {
+		cfg->fpe_csr =3D EFPE;
+		value =3D readl(ioaddr + GMAC_RXQ_CTRL1);
+		value &=3D ~GMAC_RXQCTRL_FPRQ;
+		value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
+		writel(value, ioaddr + GMAC_RXQ_CTRL1);
+	} else {
+		cfg->fpe_csr =3D 0;
 	}
-
-	value =3D readl(ioaddr + GMAC_RXQ_CTRL1);
-	value &=3D ~GMAC_RXQCTRL_FPRQ;
-	value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
-	writel(value, ioaddr + GMAC_RXQ_CTRL1);
-
-	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
-	value |=3D EFPE;
-	writel(value, ioaddr + MAC_FPE_CTRL_STS);
+	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
 }
=20
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
@@ -741,6 +735,9 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct =
net_device *dev)
=20
 	status =3D FPE_EVENT_UNKNOWN;
=20
+	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
+	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
+	 */
 	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
=20
 	if (value & TRSP) {
@@ -766,19 +763,15 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struc=
t net_device *dev)
 	return status;
 }
=20
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_typ=
e type)
+void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *=
cfg,
+			     enum stmmac_mpacket_type type)
 {
-	u32 value;
+	u32 value =3D cfg->fpe_csr;
=20
-	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
-
-	if (type =3D=3D MPACKET_VERIFY) {
-		value &=3D ~SRSP;
+	if (type =3D=3D MPACKET_VERIFY)
 		value |=3D SVER;
-	} else {
-		value &=3D ~SVER;
+	else if (type =3D=3D MPACKET_RESPONSE)
 		value |=3D SRSP;
-	}
=20
 	writel(value, ioaddr + MAC_FPE_CTRL_STS);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/eth=
ernet/stmicro/stmmac/dwmac5.h
index 53c138d..34e6207 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -153,9 +153,11 @@ int dwmac5_est_configure(void __iomem *ioaddr, struct =
stmmac_est *cfg,
 			 unsigned int ptp_rate);
 void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt);
-void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg=
,
+			  u32 num_txq, u32 num_rxq,
 			  bool enable);
 void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
+			     struct stmmac_fpe_cfg *cfg,
 			     enum stmmac_mpacket_type type);
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
=20
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/=
net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 453e88b..a74e71d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1484,7 +1484,8 @@ static int dwxgmac3_est_configure(void __iomem *ioadd=
r, struct stmmac_est *cfg,
 	return 0;
 }
=20
-static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
+static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe=
_cfg *cfg,
+				   u32 num_txq,
 				   u32 num_rxq, bool enable)
 {
 	u32 value;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ether=
net/stmicro/stmmac/hwif.h
index b95d3e1..68aa2d5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -412,9 +412,11 @@ struct stmmac_ops {
 			     unsigned int ptp_rate);
 	void (*est_irq_status)(void __iomem *ioaddr, struct net_device *dev,
 			       struct stmmac_extra_stats *x, u32 txqcnt);
-	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			      u32 num_txq, u32 num_rxq,
 			      bool enable);
 	void (*fpe_send_mpacket)(void __iomem *ioaddr,
+				 struct stmmac_fpe_cfg *cfg,
 				 enum stmmac_mpacket_type type);
 	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index 3e50fd5..7791e9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct stmmac_=
priv *priv, bool is_up)
 	bool *hs_enable =3D &fpe_cfg->hs_enable;
=20
 	if (is_up && *hs_enable) {
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
+		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
+					MPACKET_VERIFY);
 	} else {
 		*lo_state =3D FPE_STATE_OFF;
 		*lp_state =3D FPE_STATE_OFF;
@@ -5838,6 +5839,7 @@ static void stmmac_fpe_event_status(struct stmmac_pri=
v *priv, int status)
 		/* If user has requested FPE enable, quickly response */
 		if (*hs_enable)
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_RESPONSE);
 	}
=20
@@ -7262,6 +7264,7 @@ static void stmmac_fpe_lp_task(struct work_struct *wo=
rk)
 		if (*lo_state =3D=3D FPE_STATE_ENTERING_ON &&
 		    *lp_state =3D=3D FPE_STATE_ENTERING_ON) {
 			stmmac_fpe_configure(priv, priv->ioaddr,
+					     fpe_cfg,
 					     priv->plat->tx_queues_to_use,
 					     priv->plat->rx_queues_to_use,
 					     *enable);
@@ -7280,6 +7283,7 @@ static void stmmac_fpe_lp_task(struct work_struct *wo=
rk)
 			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
 				    *lo_state, *lp_state);
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_VERIFY);
 		}
 		/* Sleep then retry */
@@ -7294,6 +7298,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, b=
ool enable)
 	if (priv->plat->fpe_cfg->hs_enable !=3D enable) {
 		if (enable) {
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						priv->plat->fpe_cfg,
 						MPACKET_VERIFY);
 		} else {
 			priv->plat->fpe_cfg->lo_fpe_state =3D FPE_STATE_OFF;
@@ -7754,6 +7759,7 @@ int stmmac_suspend(struct device *dev)
 	if (priv->dma_cap.fpesel) {
 		/* Disable FPE */
 		stmmac_fpe_configure(priv, priv->ioaddr,
+				     priv->plat->fpe_cfg,
 				     priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use, false);
=20
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/=
ethernet/stmicro/stmmac/stmmac_tc.c
index ac41ef4..6ad3e0a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1079,6 +1079,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
=20
 	priv->plat->fpe_cfg->enable =3D false;
 	stmmac_fpe_configure(priv, priv->ioaddr,
+			     priv->plat->fpe_cfg,
 			     priv->plat->tx_queues_to_use,
 			     priv->plat->rx_queues_to_use,
 			     false);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 0b4658a..dee5ad6 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -175,6 +175,7 @@ struct stmmac_fpe_cfg {
 	bool hs_enable;				/* FPE handshake enable */
 	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
 	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
+	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
 };
=20
 struct stmmac_safety_feature_cfg {
--=20
1.8.3.1

