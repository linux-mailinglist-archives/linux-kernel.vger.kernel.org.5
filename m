Return-Path: <linux-kernel+bounces-118304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D720888B77B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6622E79FA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3208128395;
	Tue, 26 Mar 2024 02:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rSSsk5wf"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2086.outbound.protection.outlook.com [40.92.15.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9A1CA82;
	Tue, 26 Mar 2024 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420593; cv=fail; b=M1JIxfQavzJZlwumifHqL9W7UUlxMO9gkZQ/6bl6BIMkpt/UxGcYmdHa0BOg9wweYxIvwJuG+trMGaq8vuO6DlcqbZqEhN9Udi/1nqGeh3ISPwP/nTtVtRxSBWkZnE+gZTyZT+qkAFAy6ZyXgYL/XmPAzJQx3yazU0HMivjT1Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420593; c=relaxed/simple;
	bh=ugdg/ORod6W3UQ4ahokMNV9QLtavW6XARNgCzXwwIyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C8X62hZB8v9Alm0vFr5OgXuOUmaWE/rkHCnnzuCP02tIPTMJ+FPymKzDAOcQhXrdMBM1U/xpsAMqrwDyrY2eEdLoXDPH7OfT6S9ypNAJ0CROAMa3lKaT0+N7Lqy+qPEFtv7ikPgxWq6ykGLgjsCggiYEyB5nH1CSq6TcPlz+EbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rSSsk5wf; arc=fail smtp.client-ip=40.92.15.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TL0XmyibaV0zPM5Ymky2oy7cLd7nTMQMBc/oXQnSAuv9x9G2nItNfLA8Y+g1C9uJsA557ULcNRLKyOkwfs5dNQN3ImQhi1xIvAczUjPf7H8ytFjEUO2zkhYn+1OHV/vatnqt6O2LYCd/Yhrf0QcM1lZJP9aHBTik1QkduxOjZvfJ6h1E0rJi47NYuw2IYCQxC+4LIIS+qvtaJSjAgn37RSnLQZBYnKWgquwzEKckEmuap8rfxY3y8v6FNkda6p3G0qiaVWySsMZTYY6b1OuzXC3TCvlGKH7U8zzZCTCpV2BqdcqfSmsn/lH3f+oFyMT7D8raHX0RPx1G9K+zh0xQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnlPYA4SJsyyadPgtRaj8OyDXWzquF3l5+nwFhTHO1A=;
 b=hrmUOQBdrYlObt2VC8eZwiORogMoYYNaYxqskUkRidE2Ymzy6Vt3Qgs63RsrykDSkYiqoG6om5wLhbES7BPdaWzN/61y2ZETnZ/HO8xl/B37g2PuxAay5PsTyPCMx4K9Hoq5iLPNSK/ke1s6sYVNdkdr9V5s3MqAwLOnmhyxLPpxvK3fBD0XB98P74oCvav+obeEnE8RnCAsdofaqJDrfFTgNey4JtvVWe7rqGZIK3ws3goLOMPNLmhhwCG7HU8YcDpVobNfPlScgRRR4R7DZzPD8uwikGpmW0sKUpdAGfgvlcDTuUGTpZVLx3kG0V57I0X01xrCS5RCDQuWFX5STA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnlPYA4SJsyyadPgtRaj8OyDXWzquF3l5+nwFhTHO1A=;
 b=rSSsk5wfqrqMVRt7FVUiJ/B6z2u6trzzs63BPtcORlGwCn4zRqdnyq4QTrMnW90QKVJM/r6xbu2RxHJNo37NuZeRBxeqIPsb23jMgnULAVSNMXccvLW8LkOWg5GswPO147AoKVsYqsBIMi9r3axzHfDSqNTC3kywwU9+dpocEZRF8r6uweOPRy9UxjDAiZz7EeAAFiVk0WrHiX0wvumj529KvulGJXSZCvZ+faawF7KKGiwoiP/wJJkjiUF31SWLDE0nV960nkZS3hTiOpD4Pt7NaUEboVKtNmUNM9XAolTF3XQRoniGY5NJZXlU1O/r4naEHO0ypreN/rL7/oV0gw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB4394.namprd20.prod.outlook.com (2603:10b6:806:22a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 02:36:29 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 02:36:29 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/2] riscv: sophgo: add support for usb controller of CV18XX/SG200X
Date: Tue, 26 Mar 2024 10:36:37 +0800
Message-ID:
 <IA1PR20MB49537ED844CEBF19880326CEBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [CCg/90J1tirDtzSd9x1AkuYXJHiKY567afx/Cgbu7ZM=]
X-ClientProxiedBy: TYCP301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240326023638.381069-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 24338e9f-3007-4f47-e10f-08dc4d3d8a1b
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6d4xbak4tYeMB0D40EITU903omFSgf2CP9inXnVKgkP1eE6AT0cyom/K12lFStc/uQ316xSv1WD/N7KTFP4V+BYpPk4KRRvJO7KH3ppkNjhyD2lgEhhEdymnzF61rnlJOpOZehj8Ao2+ARhxLyVAH/+tOfuooXF8QjHl/3dfuXaR3S5d1alho73khytEsVFMpSt8l849myJKDyvQzVQnjuo/8BV4D25FZclxKa7fT837zzKz1LAPCUH9dWFPbphnLhMKy0Yv1gGeOfrxxOf+IqsXQKKuA9CQ8iHHpbCKHPa2L4SHfF8nToWshZ9LTo9Zyisev7tcMvXMC/6iNaM6YaCTe4Kwi24o3pc4KCgGj93xuZPcsp+dBCmbqaqKV4PidxeMRVt26uPx0T0bUwFL0dzrhmGl8O+Tg6DhLvmLkcSujtlHGEHyiDuCCWY17W5WFqytxSC2irFCCjg7rF4DiMy07dMimbciGBNyT0ePlZjqI9n8jmOoVIN1ntD0iaO0qNX+JN1DyjsMsnN4Pfoq4GTBQMHzPadByV2oGHwtwtPHvOT+GbmWNRwBY3uCOzm9BgIbieipLkWB94RtBes+rtJLdKBAr7cIYp9rh6JcLoE2zoZO+4pTn1DUoPfZS54utdEDPJsqKmRJq2wYEBcQKniIUcX9+PLMOz+myl5xi3z/FpEFXQH4kplbzcMUpFKQKDLukfyB8YvNlO1JkVpnyHQjU41RHsWqi4MC1hlxBPPv2A/gkxslGElfvAtO21G+Rg=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bdAOk5cSyCwP4cIrqi3mgP874tJuO7DEnKiqEYpT8cN3D70quTHv7mX2iH21S0c/gZZOSk4Y9/qQJhLDb+hOI3n3ByIZs9toB9wLaP83Bzu2v4HITXznH8H8QTx4MaCSylR/i63S45LQIiKQs0/bXJIr1xQz2VfJMPz0ZRIQJsXxPtSPnTxBrMgJztogjZDo05oEZHbZm2Oo3bxAL/zQSm99ARuY6thr1rZUYN6ukDoVtdbj/6dKpSE/GgbhANZsZZ8w1XU6SKxKKGvdXNYbli+D1KLw/5LxxDIn5GPL7VNLKo7N/OUgGzZS9DxGyXIecwWpVMLmhcza1izpm2wug46BMu2543JY959aMK8LFkDgud0JWNK7qyfF33aH2NV6F2tcva4ZwckmCnyvdR4FnqDuSIXubpxADOfN0V+h9da6YiuNAqkgGx5spvxQ0QZahiES091NBzxXVFGNti6xpeidJ5nkuT/rLKmCOlSioD76KmCNYyoLKzdPCDT5RRI7wlPBGKl+k4jRXuYO9jDGAizamnT6N922Q1RVr1BNTvabJLrVJEsdJcTA7yVCixcRJJ4HeRm0ANDQ0/2M0uhfDG2ZvA/KsAnkTMvixdp/PX0Wk1QZg33Hj5VR0MYQXqSL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5CYFm0c4AYsXd5Zhdl+w9ddsX5aOW5ui6w/eaUbWg6tJ8MYq9ELqlMaAGlee?=
 =?us-ascii?Q?kIEzqWVyB6pKz6HG/bYb13yD8S30p4BOpcPMmSGuYpMvLgygZRLPEOcYce6z?=
 =?us-ascii?Q?sW75L6NGcRi9NGI3g3ej+r7qt0xHQ7Dke0UDnS7AAwbdtUMloGFSHeLLOabR?=
 =?us-ascii?Q?VC1FdvAbf6XWaDBeORDSjFRqD4w8lXOgPIb5x3Vnq/P6RjOfQcntqZAGbnXh?=
 =?us-ascii?Q?PxbA75aPMyB/PUg5K6udyKUZqO460zkE35iC47SVzzdx8HEPpTMNuBypEsqW?=
 =?us-ascii?Q?TkCvIg+AFnuTxIePUanWAafMGasl0qrp5E5eMPbPpEptLQCRzCA4vRDHtq7J?=
 =?us-ascii?Q?lJWXGfnd9qsyoSe+x1AmtsubTRI8qendxRDqAlv1kiVzNF4+MfxFLxR1PcvV?=
 =?us-ascii?Q?6QsCXBSUpG82qsfiFLRT6rIK2dKMa1q6nEpb4xPlkn3B8taabz7iAGNV/k8L?=
 =?us-ascii?Q?jVpG2tHWj0z9luJJ0yB0Xg12Opm5j3LZ9V1qpc+w+MppiEp9RQ7ywAqtUOxR?=
 =?us-ascii?Q?m88HLBvB8g6beTAez++LXCn4iw+I8qhIIaF3Qlij0YRYG+rwey8/mH8snC7f?=
 =?us-ascii?Q?6kP8qsCihkIeaTYLUbvIokzHH/cRWJu5ApfphCGF45eBdkwtb4uFOAwpNRfo?=
 =?us-ascii?Q?DIfpi/ukWo85AfHXK0wN92O22Kqz21qizVlxik8ZH5crNqWp6XcEuPhdkHDS?=
 =?us-ascii?Q?cRhKJ85f1JX9Y47tacMp9nQguzybIdFaGTVKdmiTDe3vGrgmGz2AhWQESOS7?=
 =?us-ascii?Q?xBwSyvS7mdWCEQ1XTXH5CzlEQ7AxEpMe3/5+mupGH0vgKsGEUZDrUIXuhr5X?=
 =?us-ascii?Q?BiS27nDSfge3r/tbk4bQBfV8fB/FILxJGVytG3i5pvrtMP0bSvQo6m18UHve?=
 =?us-ascii?Q?M3A2lbv4Gtj1iN8iLJDQfwlQckfQ1FkYeE83uezkeVEPNVYtvQtVOVNHBp4l?=
 =?us-ascii?Q?Ky0DJHjI3USEwG0k09FZbgigr0DCT55RNcPsx48OZndyLR0f4YptDGYOJDp2?=
 =?us-ascii?Q?CDhRjGeE5NI1EIqOYy1e6r7namBxMVVXmtSRZxLwpQ3Pf3pUkw7qVHTO2wqc?=
 =?us-ascii?Q?WGaHqtjuWqtDgF4n4QLJBmKQ2eGJT7cAkVddZo0yD6p3MHzp0oV/TCG0MrEr?=
 =?us-ascii?Q?+0qBQzRZBw3e4R0gBH4We/O52BcxwuqHeepLh1lCa3g6LHKggIBKe6GIsUXc?=
 =?us-ascii?Q?qD8iyrcXAvqUnTda6FsqKPez/25N36393qm77uF2xGd2FjoavBHRSFjx6Be6?=
 =?us-ascii?Q?F8t6CrTjIvWc0YANPlMy?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24338e9f-3007-4f47-e10f-08dc4d3d8a1b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 02:36:28.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4394

Add usb controller params for the DWC2 USB ip in CV18XX/SG200X

Inochi Amaoto (2):
  dt-bindings: usb: dwc2: Add support for Sophgo CV18XX/SG200X series
    SoC
  usb: dwc2: add support for Sophgo CV18XX/SG200X series SoC

 .../devicetree/bindings/usb/dwc2.yaml         |  1 +
 drivers/usb/dwc2/params.c                     | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)

--
2.44.0


