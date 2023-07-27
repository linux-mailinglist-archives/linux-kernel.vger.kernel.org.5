Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA677651B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjG0Kzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjG0Kzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:55:49 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2087.outbound.protection.outlook.com [40.107.15.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40073B4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2tTxKOyKruFIxns0SFLHDa7WDK6a6y/TLbHTxFtIW4=;
 b=y1gD1OHHjI0iHOs6KtuVdUcwwcPxqvF6AMD0wOclwNYI/rOcRWlPC4VJKJ7E3e4HP+CNzIFBwod1YYIclI43yecPVtI04zKlYuMDjdMiEUhY4yQrHA0O0zUvQ2pBEFOpjO5zDWusRBfcoXnHiwtThwKkHPbGNCZB3AuqBrg7x9o=
Received: from AS9PR06CA0531.eurprd06.prod.outlook.com (2603:10a6:20b:49d::26)
 by PR3PR08MB5850.eurprd08.prod.outlook.com (2603:10a6:102:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 10:55:43 +0000
Received: from AM7EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:49d:cafe::de) by AS9PR06CA0531.outlook.office365.com
 (2603:10a6:20b:49d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 10:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT031.mail.protection.outlook.com (100.127.140.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 10:55:43 +0000
Received: ("Tessian outbound e1fdbe8a48d3:v145"); Thu, 27 Jul 2023 10:55:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 014d1c199de25b22
X-CR-MTA-TID: 64aa7808
Received: from 78d79df7e4ec.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A93CF96E-58E9-43BD-B8FF-22CCA1EF9DF1.1;
        Thu, 27 Jul 2023 10:55:36 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 78d79df7e4ec.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 27 Jul 2023 10:55:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9ja2MLygjGVfcAfV9uGH1TeSxumt2S6CvaAIwNSQJDftyav8oaLsHbvIHpK8FPK8KF3yy2G8UuNcKzO4VH/0upfuJAgcm9HL6beyQgOioLACK14CBHVkEcSQSo4Y3QizzLnHTRgQA6J4eS/JGskjKFsAxwjNbk9vqyAtkpX+8ExLd5lFraZAEhNMYpGGxfZc2dq14yuarua2y+yDz97uLLU4+Rfb1pY8b0nPlKFBrKl++YB83EIlojJc/u3nVj0V8NNtli2Tq1iYnvppJqgO1exZZ4JH7z7YTzJ0Wlu9rFO2HjW7G3j9EBGBVcGSwIOIan7ZdqMTnMAz6QY5jdV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2tTxKOyKruFIxns0SFLHDa7WDK6a6y/TLbHTxFtIW4=;
 b=X+8QuqKCoqDWl4+NsMo4uO6XkBALk2ZBoUsrJ2FyB2XjytOEg5hVs7yy3hWSw3d9RjSez//Kh7bcxV2ywcjXja9ciXdIkd/lFph1NeKVCH6NsDrfmNHKZVHxD491rNjfCBQ/xj39gcOJRnTUAY3FpKPbgdz7A7nR3LrDP9pileU281VcE1ONsVB4WlUCQJR8/qxq7RGWtbXldtgZGn6mZnUF3xiRDOL+xTSCCp2b5EdOIvks/UWEqRrxmIr/eg95R6W+zQE2S0uGZ2dEMXrcsCnpSassmVSd9UY2LltUhEztI8NeTbHO35q3v3oX8y55k9RXu1kfwR+Pywo1JT+2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2tTxKOyKruFIxns0SFLHDa7WDK6a6y/TLbHTxFtIW4=;
 b=y1gD1OHHjI0iHOs6KtuVdUcwwcPxqvF6AMD0wOclwNYI/rOcRWlPC4VJKJ7E3e4HP+CNzIFBwod1YYIclI43yecPVtI04zKlYuMDjdMiEUhY4yQrHA0O0zUvQ2pBEFOpjO5zDWusRBfcoXnHiwtThwKkHPbGNCZB3AuqBrg7x9o=
Received: from AS8PR04CA0055.eurprd04.prod.outlook.com (2603:10a6:20b:312::30)
 by GV1PR08MB7684.eurprd08.prod.outlook.com (2603:10a6:150:63::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 10:55:32 +0000
Received: from AM7EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:312:cafe::3e) by AS8PR04CA0055.outlook.office365.com
 (2603:10a6:20b:312::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 10:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT026.mail.protection.outlook.com (100.127.140.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 10:55:32 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 10:55:32 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 10:55:31 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 27 Jul 2023 10:55:31 +0000
Date:   Thu, 27 Jul 2023 11:55:30 +0100
From:   Joey Gouly <joey.gouly@arm.com>
To:     Will Deacon <will@kernel.org>
CC:     Jisheng Zhang <jszhang@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nd@arm.com>
Subject: Re: [PATCH] arm64: vdso: remove two .altinstructions related symbols
Message-ID: <20230727105530.GA1854855@e124191.cambridge.arm.com>
References: <20230726173619.3732-1-jszhang@kernel.org>
 <20230727101926.GB18721@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230727101926.GB18721@willie-the-truck>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT026:EE_|GV1PR08MB7684:EE_|AM7EUR03FT031:EE_|PR3PR08MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: aa94e2fd-ac60-4a9b-6e91-08db8e90062e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6g83fnp0guMDX7XzfGviJ7n7KVyLoL+bY1t2GUT1oHpZoi2BdZBsOaYvmqTSYhL8DvHtAjRKsWlzJJqQm0cQ7K7lUlvNrdHK0y9Xy29k+H9GFArgj8mYAUKhp8GzAJLLaPnmVVWErxlcKVJx98FrO3o9GVOTs6zrt3THshTj43PBlYTv9OBa85qp5JWLiysRxClM9Jvmwx4Sa4+p/LadG5ywURyGDlpKOxE2crT4YG5zv/lCvm0+5Nl6IW3hSeZmtfVafaCnm6MEGXA73mr1mb74bfhowQd1c0Q0PrCCWammjkIm90WHznn4U4vzKFfK+uEeweLfDDH0FQ4dkiyE4hKosrKJCKFVgdoFKu7GVkSXX7zZIVW/UgOYU9P41gEAHpGLAUydUHCfY73fNOGCcsXlPqsY0RVOxK1tArAjVoh6Bdnrd9tnygCxsbOy+1zUt4s5ivQwD9vcgnFdB5YzylbTUiByeCD4FZ78rqzP8TFlVyZpko0Zz23dhZQukr3OKfZtCx6y2qjKX+iM/ZSje23lDRQPWbThf7DHxRRNYcmfDZlTjJLU6HI+kUBpVvwgcNSXuXxGMfChO4hj4v9Q9HofN9LO8RJqjy3AeByqnoJYCu9BvWlT6Nm1ouLp8v9d8g1x8dsm2DZRnDINEIGYRV0/qy6omGBCAfXsnEozt+WgMb4f7oiym5QCo5t8NNgzxRM8Bc9gKsc2ktdRej346Zp3wLDwZ2nqBB4MfL61UXof8g9Q/dVlydRq/eVwPOgcQ045euEzdNsKDE0QfcG3KhNQLMrfPKjN82J8tvQ61U0=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(478600001)(54906003)(7696005)(36860700001)(33656002)(40460700003)(55016003)(86362001)(40480700001)(83380400001)(2906002)(1076003)(47076005)(336012)(426003)(186003)(26005)(41300700001)(6916009)(82740400003)(81166007)(316002)(70586007)(4326008)(70206006)(356005)(8676002)(8936002)(5660300002)(44832011)(142923001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7684
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 70753f60-f7cc-4991-f7f6-08db8e8fffe5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4O+qyOLDmm0dRBUIimkRvPQOK/tWTZNkKy+ANbIIr9m1JzbY6FKmtXZeWZ4mQReGFJiVsmARcqA5HtrpHwHpbRgRHcneBog+4q9DzqpcIMKFMgV8qo2tsqM48E7h4hCSfN4dBx96Kjbsn+PMybxbqqqTOdaKzMBecmq9+yHbKKa9heCoc57sXwcY9yZczipWgJvTQ3ITUkQNZOmfs88oKkiqIFh7IoPvSmQ0qTvM7Kr5D2XR2gqdVHrdibQbRn0O1DGxx/bz1iy4QTOzDYe8mYZWMOwsHgFtdKe90Cws4MCCIsBGDlUMPJacsXaOwmWQKHOwHSGFUERuebNQRtp6qpiJ657HYA5ZhEG9j1FPkp7AfLWixl0Ev2GkotGE1iFV0blLG86tv1JxFC+hYGvfl5nRdYWKNxVyZj0Ld/ZAml11/XzXq4AQeqZ76Ro8QWdpvvb5hKnW9gO1RsEvc0UVO1cWmaktW/io9hdqTdKCi8Gd23E8Kg+/4jE+lbgn5vhdetMI6kq5EAL+cq+l8/I9NS/bAOAJgJYlMwPqxdB5aFLDe4nzG1n/RLXf/6Z6/96quPNA8ixWMiXDqRttmnNSI1fHMTWOpoLLBJsBI5DaN2VFMmLT/xxPBWJx6Q+FiYHNi6SBD4roNIYwfZRilzj2nThmMbWWbmxHQiFobB+9ifZV1xQS6z0p6LcTB3WS20yf+dCH8u/37Nm4rq8c8D8ckUbEd3+QojUXdGPN5Fp5iSVCPt2mWBWx21m9uvSvOVguRAGPcM49RAf1GSypgJ6Oaw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(2906002)(41300700001)(316002)(5660300002)(44832011)(40460700003)(8936002)(6862004)(33656002)(8676002)(55016003)(86362001)(40480700001)(1076003)(26005)(7696005)(478600001)(82740400003)(47076005)(83380400001)(36860700001)(336012)(186003)(426003)(4326008)(70206006)(81166007)(54906003)(70586007)(142923001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 10:55:43.2573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa94e2fd-ac60-4a9b-6e91-08db8e90062e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5850
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 27, 2023 at 11:19:27AM +0100, Will Deacon wrote:
> On Thu, Jul 27, 2023 at 01:36:19AM +0800, Jisheng Zhang wrote:
> > The two symbols __alt_instructions and __alt_instructions_end are not
> > used, remove them.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/arm64/kernel/vdso/vdso.lds.S | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> > index 6028f1fe2d1c..45354f2ddf70 100644
> > --- a/arch/arm64/kernel/vdso/vdso.lds.S
> > +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> > @@ -50,9 +50,7 @@ SECTIONS
> >  
> >  	. = ALIGN(4);
> >  	.altinstructions : {
> > -		__alt_instructions = .;
> >  		*(.altinstructions)
> > -		__alt_instructions_end = .;
> >  	}
> 
> If we don't need the symbols, then why do we need this section at all?

Looks like it was a copy/paste from my commit 4e3bca8f7cdd ("arm64: alternative: patch alternatives in the vDSO").
The VDSO patching code searches for a section named '.altinstructions' by
reading the VDSO as an ELF file, and doesn't use the __alt_instructions /
__alt_instructions_end symbols.  The kernel patching code uses the
__alt_instructions symbol (from the vmlinux.ld.S linker script).

So it's safe to remove these, but the section itself needs to stay.

Thanks,
Joey
