Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C591E7DC602
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjJaFjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJaFja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:39:30 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2125.outbound.protection.outlook.com [40.107.113.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDBEBD;
        Mon, 30 Oct 2023 22:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsMBPn7SO5LkO5J9Q0h9W2+2frLEAmS99p+FiyCBGFxg6CaR8VGwz9s4pnjEU/e7Uhrbad/J5+aurWNjNiYLuBv0rXvl4+ulSiEN/2dR/63DsQZajR0An7CJuQ46Gsuep9LWp7MFtAiA4a9SS+ocXEtQMcnhAhlTVd6tH8IckgcHLD1eiD1xkGjg5rhH1Zoch95yXHgs+P33XWlcy8cli5E+KYbiLOCbSwPjrvsQ14doViIyQwiTyj2P4/oath+npcigojQ26804seNSG1sxKMXwakwUHVxudiUSBvUroRgnZ7FJ3od3XF+6ohYcbcNGoCa/L/QOST6JLtz9D+Gjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bms9+JO3fKAnaN6LGCZzXbJWhjc/Ny5b/nY/FUZqd1E=;
 b=CrvUOC6s+n8YAwhAcA0wPRcdW8M90mNP0otPXOx2AwlY7HsIMguGyhE14PFqK1BDjyY1AjtqQltRoU/1Ntps/iYytm4BtYXrj4pqqwa7OAw6M5dr3UH5y0YVrv4QTmHFZet3iSMnBtU1GFVGibIYNS/6zGl78ZuS6pfOZzDtMacdgMFA4fb35vMjNxADK1GnlvDppyDpzx+gY08URtZF2R95tdB5EvewFCj3Lu0mq5qQtlTmUSdafHUDnioL5gXLQ1Hb86/msWqyeSj/DW9HAhepiOE0c46pAwk5DUgoXeHJ889ZwbdPPxF/1iQ/JxC2Oc86bt4KXC0Wa4IeY/02oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bms9+JO3fKAnaN6LGCZzXbJWhjc/Ny5b/nY/FUZqd1E=;
 b=NoBkz1vw7WJRoDO2szQxWOZ8jMNcc1/q0vSV74LhOoEfz8HP3f2vz8G6R6z+Yi1PhOM4lbZJU7rqnKLxryYyA4LlPt6wsQpZglKbKKZIVYLQqcpcgQy/yB71KVoeV1PCM6xoI/S+TrdKqeib4CfkCBRk7cY2JEKPtR5wgEuXjeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TY1P286MB3280.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.29; Tue, 31 Oct 2023 05:39:22 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ecbe:414e:2a07:b355]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ecbe:414e:2a07:b355%5]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 05:39:22 +0000
Date:   Tue, 31 Oct 2023 13:39:16 +0800
From:   Hongren Zheng <i@zenithal.me>
To:     syzbot <syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] linux-next boot error: KASAN: slab-out-of-bounds
 Write in vhci_setup
Message-ID: <ZUCTBMazbx41wmrO@Sun>
References: <0000000000007634c1060793197c@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007634c1060793197c@google.com>
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: BY3PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:a03:255::12) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|TY1P286MB3280:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2ce7f2-b3e6-496f-3c2a-08dbd9d3bbfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDoOkZVaD8EvKRKly9YpJQlP+ma/nymGDS4qtLPflID+49YrE8zhFpIt/tG9PS8e66xkB1G+nW4m7juUOOSsHrwHF/qFLzr++9eWFICmhBuB0OjiMkeoeXSzoUNiJe/xyAh7Ew+x6McOD13STviKmKbM4XZzsvePRMV3uf3nzZCQxc7i+VqU85UdbJ+gUON6U05B0HgqSxong+mnFIveVRhXEM47vQrn71cxmkgKT2576bCyenWpEiv96iUbWSJILAuGx8gaIOyZajXdHMTSpblh6PYbsN7RUIQY8ATcFUHkC6FNVr5KLYznfp4XTshRg6wxmly6DoIBRjTF0r0aOZ4cdhNUMPwpbhZ3JKiXDyJr/5f2QpKnrDGDXyahYNik3SHI4r5HtgVB9kiEnfeqOs51ihmYUnYxyUKS43BUUhsB6ETKnE8ZV9IcTsoisDplcJr3Jjg4+KkaX11Fmwu6+jNCDOOxQMORaQ86eDpAvw3e6WUWifQrAF1D9U4Ml2eAhd+Ey6VQoH0DkT1elqud9YnQxh4inTAuXbX5tbHGsKachnoe3nWq+UIcVW01DcgwtYxJ9p6fGXkNs/pVzq0Yfj0MTbMsKT3vz9um7yeWM04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39840400004)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(6506007)(9686003)(38100700002)(41320700001)(558084003)(33716001)(86362001)(5660300002)(41300700001)(316002)(786003)(66556008)(66476007)(66946007)(6666004)(4326008)(8676002)(8936002)(2906002)(508600001)(6486002)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?53fG6bsiNTIgBTj1TaXerF0fscdF8zSOLRM7oHYqHyJ1b3D+9GB24esqTtXt?=
 =?us-ascii?Q?PFDQHcKMYJLgzio57uYcaya+Tf/anj7cHlpGPbKe5dFjBBskdbur0aJNckFj?=
 =?us-ascii?Q?qU7ONvSjIHv2mcXGeOB4u66GLHrSAy4mmUxcWLj6iMQnfZhS4NhL5dTCworb?=
 =?us-ascii?Q?civc+brED5S+wTdUabA8iPu1re4cXPmW3Jmv0qsPdUBrMjcYK3NSDn7SKTJS?=
 =?us-ascii?Q?g7DKbxMEcqjCn5+7V7/i2YFky4i1jOy7iQ8JBxuEliNTL17gaYf0hYEo7ITU?=
 =?us-ascii?Q?XhfMeh/BIgnROTid9dT7AVrdELSHBDdt9a1JkXN2cvXwh3qjfM6oI+fGHZsg?=
 =?us-ascii?Q?Gg8NRgLcrSFhB7pm0H+fFowIqY+dlDPJDm/FSYwVUQyVYXn6lSfItqFrJC8W?=
 =?us-ascii?Q?bpbNBoimp6J1P+3IetuF7turosGOJx0tZTGNbz6Afp1PUXrQ6MXSLTqclW2o?=
 =?us-ascii?Q?5gGFOukLWDSutLGsKBbg/yi9Z570B7UgqBa+7Ox3g9XpkaaKN62z8udjbGUI?=
 =?us-ascii?Q?y6SeZw1uGGGIpibWicaMQFINp/kH7unLqtbG0M9EUTqPHq3+LncWeaX9WPnh?=
 =?us-ascii?Q?oLIe7frehE/tofXuLG42+JnWyoTZjVjJVHtlamUYI8QH41+DvLALSS+doXYZ?=
 =?us-ascii?Q?JP34LTgsa0qHeIrTU+FQW/T1iy17kjQY/M6SJ833lV29SDi5i+Oyv2NJXdpr?=
 =?us-ascii?Q?MkAeVerUWSrtjaBRK1YylhjZpUXzc3NsuhQIti3OoS7piLy+sgjh157lfjnZ?=
 =?us-ascii?Q?gu/N97HlwMz6vYf+BlpEMuSJpj225hH7+TgPjicWWsWGenXVthYv2GAjGz4g?=
 =?us-ascii?Q?PKPLUKIaCePdeyUeeuVb1y23v9WTP0dyLalmRXWGyCOb5t1ZqmDEN2UAYC4C?=
 =?us-ascii?Q?8KzqmADlvpSrefI2oJ07V/GvNIRxx+VgvBfi4sH5UD5H3RUlUSA5nvs8rKCs?=
 =?us-ascii?Q?IRw3VgK5PN6tRRUamsWIYgXHMEs2P1kbPRHGuOmfo4VS/i1Hfyj7q0OS0RX7?=
 =?us-ascii?Q?H501uQ5doemkIslhRSVA6SC8XcvG5W21I0cZPm+KwodWEUJ4HbbhqaGUPTzL?=
 =?us-ascii?Q?toz/6serSdbTbc3xmeHge0M0Qyz/ibSJa/WOSakDURdW3bmnT/aTt4tyvU+5?=
 =?us-ascii?Q?JqLKIqC6BSg47K6uB0lZNRD11uF1Gm84LmBglf+kuiV0kOTzNsgFw1stcqB4?=
 =?us-ascii?Q?lfWSt3CDMkn15G7OxTor4z9pRY7ftXsre6MEe7pCqonP6Z79RwEgP9TxlzaG?=
 =?us-ascii?Q?qBWJVfNAItbkJu/NfeigzmXOb4nWM0RSOt1Z72Yy3464igYNdU9OFSQGclKB?=
 =?us-ascii?Q?EM67mLo2cs7il6CRWBbOpWPuxFku2IDUREQ6EPr88QTkGNleyHIUL08jBCmm?=
 =?us-ascii?Q?k8golmTabTiRzMtULPS9B8WWrNQ4hwOe/C3q6Z7r1/G2vg23dW5F/ZuxGB47?=
 =?us-ascii?Q?yihtPVnlNm5oRQQSYvkkC9inx0zjPL7zAACfLQeyhFcAqGqIzgBCZLS9CcM/?=
 =?us-ascii?Q?IZHMmi5KdGrs4XzAF/BfDKTAr5HBZAIo1Hkgz2SJ+5UgxtTNF6K9ByY+lqtV?=
 =?us-ascii?Q?shZIvi3NlK+ZIuzt+xd7n09oAHOBmu/E1Ch16i8N?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2ce7f2-b3e6-496f-3c2a-08dbd9d3bbfb
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 05:39:22.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WT8pwvSz0NIRuA2+LksRv+/JC5xQMzctFOJgHUrjOP5t4sbA0hQucxuKLblPjVH+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3280
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: usb/usbip: fix wrong data added to platform device
