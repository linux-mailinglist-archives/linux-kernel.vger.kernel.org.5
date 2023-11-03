Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6F67E01F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376879AbjKCKrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347004AbjKCKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:47:49 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2065.outbound.protection.outlook.com [40.107.117.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A581DD7;
        Fri,  3 Nov 2023 03:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQs1d75dfjx+FemsNmE156hSpAw2aJRxcx/ep3r2Gz4O+Po0deFbyRQBwP7DSJJge+ayccQrDesjzLX9yfF681UA0m+k+KPZ2rr0b+jnfl5T0mVBZxXoVrM2+nrBTJ/QAn9lDDZ1NRENT+OZQ5fiyGffQpC935xQagWGRvvocFv77M1Gq8gaXuzn6hkPFo2f8SQve6ywfn53uGYquXk7mH6RPEuC5wng44uCYzDnA1xhWf3SQT4TrwSJu7X+N5CcfDdTTm5+0LKEyOTbaAaDfSNBarqGEKloKM0TuIF2Vi07rRmsWvnMe2aG0Z53MQ6TqL2XT4gMGhFLidlFJVNwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiMMyIpLCofZGheNNGN5/JH/HZ1bWbuCxvpNCvMLQEk=;
 b=S6cGhIvidnPl4rSZT8S0tn09NwjT0DwxEBXhwaEEsUPuHGzcMlRiQEKtPEzGRPjNxBAzH5qAvV1zYNRyxOS8gxhyH/a0vyvP0onWMkN/9yKv5PMQ1d8cPKoRnuyM4lSAOHpulM24+57d6/nA4fy6dPw3NZNcE4S7vvY4RpNZZfDCDyOrKYAa71luNN0eXGeYcZQvasGN3vK86qPm6b9z1U++X/vh8ruRs/3iV0Bk4W63PuQ1DpRSxaUyZ4sJGxOiqY/rVDujs4tbCmOQkIzAAGp+vaaDRp4prDyQKzw1T/uDODayv10Le1wz+8FWegD8aBFRSYfTEzZdVchJIQjMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiMMyIpLCofZGheNNGN5/JH/HZ1bWbuCxvpNCvMLQEk=;
 b=SgrWjbapzPQbUUUmn+O+8GHq4MzRotTJz9ym29UwV1fEmQrju9Q2hmLhI+ujvXVXEVzdZpc2ytuJf8taPvVeCHuW9k25b8HKd/5bEvUtth5alArQPmhV8R6YR+atIFKkTaG7qfr5m2ZQYBRhEUfqcuunj+0m8Lj9PoIMi2fKCg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4578.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1ff::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 10:47:39 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::5856:88f7:3f55:3d72]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::5856:88f7:3f55:3d72%3]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 10:47:38 +0000
Date:   Fri, 3 Nov 2023 18:47:34 +0800
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: Add RS422 flag to struct serial_rs485
Message-ID: <ZUTPxkEbmF3jajQg@moxa-ThinkCentre-M90t>
References: <20231101064404.45711-1-crescentcy.hsieh@moxa.com>
 <2023110127-wireless-candy-c298@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023110127-wireless-candy-c298@gregkh>
X-ClientProxiedBy: TYCP286CA0370.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c7b049-34d7-4ee3-d32e-08dbdc5a4c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzjerleEo/Lq26Y/hGNDDMvL8LJjzDdoQbCbcRNX/Qy1bVSSiuQvtKBSjGCg7F1F8GF/WWNI6tleouHl5OpHqpYqINywtsrNcR115iDNFL7Jqqk1huIVE+DOoXVDKagcNJEgUstBVVUbs7JftLfPLDD//SNQkLcXCI6YcZ46rUEdOGQGD1qcheZlNn6m1p6fl5IhafTS1RygwPct7cGssaqN9+csWuKK7orBaRIoVtp/CCmI/+y4fXS3vxDjon0icb291u8TrpBQ9wxv28mHdcIdhRIuubIxVhV01cVhA/bdXSCNXokfufI5Y5XyLrYEmFazXrCwtIu3eOCHcF2BALEDicjZU9iPb9QbmV9oPbYZdWEcKLfitq+BADPna/+d+P3pW8ecg6qgggtZXiJXJ9X6vdudIF2SS3wGROaiXKeJAaJrP4b/Lynq3AWZbEBsvo/VYjxMcsuqnKsQye9vNFBHmwicBIbAwWbnGD2GG/qxLVmitm7wUO6/t7hXgq6c+jj4iLksbD9VkZSmWEa1Q7hi9DvvtLAG3qyl78/CqoE+/1OqkVNDFWKMyWirgc4IcT2Le1CGC/4fpAYYpfpPmnd6o2R3a1qKmslPE+UytjLuJVo/PMDeAzOozxMzDven
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(366004)(136003)(376002)(39850400004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(316002)(26005)(38100700002)(66476007)(66946007)(6916009)(5660300002)(66556008)(4326008)(8936002)(8676002)(6506007)(2906002)(41300700001)(6486002)(478600001)(6666004)(9686003)(52116002)(6512007)(38350700005)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yaL4WOO5B/Dl5H+zGGHCNuq0Vr3Ja32gO/MCgs5wGMjhKlAfVqbiRexOZkOj?=
 =?us-ascii?Q?ZSw9lDF/xuTd3UIkICnBmnzVngm2woKYjsLRrEO2d9FSdtxzsfbBQ1/Ob653?=
 =?us-ascii?Q?guMpSJ7wjyRvo8hVrjMMhaQdICt2wWU5RU4ak4iS2d7X0F8giiJQBhJAgvH+?=
 =?us-ascii?Q?6kT39cGHQJcRegyrGkfFvydJD+EQ49serUwQrDBd07HW5aZNrwDvUO+c92V0?=
 =?us-ascii?Q?FoC0+TzRMmVoCucKVQ8HSC/86AUplAYa1nyLuiiGqb3u47yxUVJbfIPmiAA3?=
 =?us-ascii?Q?wdd5xS8DyzL9WXLxR3V8P5IeiivbELRID1gmfb3uXE9ukl9P7+Jjpss9Zm4k?=
 =?us-ascii?Q?d/9venDtpZw5GRWfBGBol3W5G0NAjHsWQ9kaSqFaURd8cIHtBlzSoF2kquqC?=
 =?us-ascii?Q?b2Eb6ghPlwp8inN8CvmSQmmnD4hz4nMqUx76Lkm/CJAl7t1HelhT6I5LboMU?=
 =?us-ascii?Q?i84McGLQUCKPNgFYiaXlcEhforooltpnKKw5+Edb2Mj1ahWpUcaxd2bbSVXo?=
 =?us-ascii?Q?yUSTcgxJyl2lz/Qt/HcnAFcQ5S+FDosmgOC7KOCwqIat1XKGNcOQTJ4mkwth?=
 =?us-ascii?Q?4RFGBaxe6Efr4t+JjO1tG+X6BrxP9umBc/wBwHGguCRh9DhTO9EhH9M0/Mkw?=
 =?us-ascii?Q?0lj3vpkOrgthdi2IRaMDzGoQEjNkHXvBLtgoUK2NegZV+8A9WuJSqhqEh6Qb?=
 =?us-ascii?Q?j/DIwtlESKfGsDG23rpgk8FVxMyaKXuyLKJSGww1Q3moYqoyI3sJZt2XNYD6?=
 =?us-ascii?Q?LuEIlB5z+AYoSqoe157ED1lJo0/QDa84kIvuufM8bWndW4jVtBWgTGeXtT6F?=
 =?us-ascii?Q?Z+PW3/b2x3DFS+feb4u27n4g+4NoHSwaIRanZy2stk+lVYG6Ax7xuWdj18BF?=
 =?us-ascii?Q?fT6QwYrShpuTovtg+BRElTMXFELHhQ8Y0kfLM2vo9wNHjAMxH5/haIgM98ZN?=
 =?us-ascii?Q?nI63zqnX2TOGMnuWHxXu5lPRFIXJHgBdAfptKY2GSAwqQJ38Yd3ebhBkfh2f?=
 =?us-ascii?Q?OGTPtw5H4Pm2kDIztjMMCb1nmb4b/tisSVgDRis95+rHfN76/4Kg4ovnhok9?=
 =?us-ascii?Q?F8wQ0UZRM+uL9MRNKYRONG5ITqmTBC3/qxSqvc9cCUHQYa7Rx+Y/cUrjNMaO?=
 =?us-ascii?Q?ElbEfRXcPL4uyRitpSyr9ERn5aeZtEpCwA55rSRkaSydbxiwmGb08N4CH+5v?=
 =?us-ascii?Q?v9l2ceEZwmJOPkEWPXZZeuf9+1Nd4jDWD9GmWr38PEVTUFn0k9yF9LU1WiyG?=
 =?us-ascii?Q?ErNt0bl+P2Srn7mSHNRvDrUd9Nu+jfphLlkeIdyvQYtkiOhazkBWIc1jYbxQ?=
 =?us-ascii?Q?Rv2bMOL5InsYb8/8K56phf2pARfwbuJiF75PBf0vF9JbbwcOFOSIcprQoIhx?=
 =?us-ascii?Q?ZR7Rcg8vnsPBYow36wE8Ux6Be8JdMSIm1Pnl/sPvIIEnIfPiC7T0QPAP5y+s?=
 =?us-ascii?Q?Xth0Y6D8r8+yHEPws9cv+8jCgJwgt5J4Xly8rsZFbnp27/vR/IXIwKZOElkl?=
 =?us-ascii?Q?MS+wxVXA6HvAZlVkxByhwHh0r3EzzmgEgGzOairHx4ystGGwXwS128+5o0aV?=
 =?us-ascii?Q?v5gcsrmKceKjoK3A5hx5nU6XI2urB+Lbcqq26K9gVan3e4pWbOwUOBpYtqMG?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c7b049-34d7-4ee3-d32e-08dbdc5a4c2e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 10:47:38.7741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIs0W2wzLLDYjKZmkaR2RTDurPLQH3/nX/L7kvt1Dm89tyvIKFtPgaK+vDAmtoDL0MtQeEtQmfUojpYzSei3DEivSfSCLUemd1vPIC9dYg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 07:49:48AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 01, 2023 at 02:44:04PM +0800, Crescent CY Hsieh wrote:
> > diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> > index 53bc1af67..427609fd5 100644
> > --- a/include/uapi/linux/serial.h
> > +++ b/include/uapi/linux/serial.h
> > @@ -137,6 +137,8 @@ struct serial_icounter_struct {
> >   * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
> >   * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
> >   * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
> > + *
> > + * * %SER_RS422_ENABLED		- RS422 enabled.
> >   */
> >  struct serial_rs485 {
> >  	__u32	flags;
> > @@ -149,6 +151,8 @@ struct serial_rs485 {
> >  #define SER_RS485_ADDR_RECV		(1 << 7)
> >  #define SER_RS485_ADDR_DEST		(1 << 8)
> >  
> > +#define SER_RS422_ENABLED		(1 << 9)
> 
> Why the extra blank line before this?

The extra blank line is for the clarity, to seperate RS422 flag from
RS485 flags.

> Also, what userspace code is going to use this?  How is it tested?

This flag could be used when user tries to switch serial interface into
RS422, just like the original flag "SER_RS485_ENABLED" can also be used to
switch serial interface into RS485 with some RS485 configurations.

---
Sincerely,
Crescent CY Hsieh
