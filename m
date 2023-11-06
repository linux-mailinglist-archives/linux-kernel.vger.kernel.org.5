Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F327E1B02
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjKFHUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjKFHUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:20:03 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F64136;
        Sun,  5 Nov 2023 23:19:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g53q0znUqN1ZWtLSeglu088ufeAcDmAKBqYlj5BdHA4gklAISOtLsRv3kUlFUAxACrDjaXts1diI7alVcKSD8PRHf1PDtrD9YqQRCHcGntRAwAXMzanXUHy5w8dfSaDV6PJy/EIvk9oaCb/3woK1WE9P+qZ/ua4mUhbQz1G4bPR8/2g+9wm0ux3QKBbUJgM2DTkAZRHVAjT28NRvdwxGLNnwpmE2m/vGKHa+w3hQKIgysj6nW4QWCEM5rGIoQc5o0K7y9ckx2XukmM9Wk0u0PXpzLf0ahmc0VNnkQdARRm/CEkzWIySKYGoWVmxzyag7MPKGW13zDdOJQxueMABUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpt55iI5xkEEl8JJezliMeiepzn/zXjWknsPt9czSTw=;
 b=LX4qHyTXW2fM2IqpGosDc2JH75FKlAQHu151Shluos4/45OawA5OD2nrn8wv3u0krW7yLF3MxaJdWKZJeKpfcomr3bPZoxbGCv3MFafki6rGx+JURLcgu8T0392VCtZ0Y44G9sxu8DRGpYLJqBTQgSm/fSxDPBl1P9CdAWtlpVfe+Wi3vbK9sq1athaP4lGvher2LWuYC+43Y1/hMHPA2AVfcX2N7sjjC70cGbzlU+HlMcuu2RexxtEh0tjsA0Wbhjch+bhnhFcUFFamWKC2TEpbntvgSUOUZE5dIy6zzzhXlAyDS1Y3Q9QDXsw/xDrmxEwMk+tr1YLPa5oV1hM28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpt55iI5xkEEl8JJezliMeiepzn/zXjWknsPt9czSTw=;
 b=jUF3O+DprFPd8kC9Q9cHgLaANRDy8r5oLtiPZS9o2SVsLjfriX6VQTIgYbQYaC5wSZqJwL0ovTMhpXBOduTbZZ9zl8qRBp9gVZGCXcDpZLc5HKVrQ/VhyXDORY1a61iI1UJBd/pD7tdW5ifUDffq8YOzrTE+3TsRhuNulAGD5h4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by JH0PR01MB6380.apcprd01.prod.exchangelabs.com
 (2603:1096:990:9e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 07:19:56 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::a480:d88f:100:3a92]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::a480:d88f:100:3a92%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 07:19:56 +0000
Date:   Mon, 6 Nov 2023 15:19:47 +0800
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: Add RS422 flag to struct serial_rs485
Message-ID: <ZUiTkyZSbbmTUGYQ@moxa-ThinkCentre-M90t>
References: <20231101064404.45711-1-crescentcy.hsieh@moxa.com>
 <0d203024-ba5c-4258-b549-b9304622978b@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d203024-ba5c-4258-b549-b9304622978b@gmx.de>
X-ClientProxiedBy: TYCPR01CA0193.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::12) To SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|JH0PR01MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: d525f548-23ff-4e64-046d-08dbde98c709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnGTVXNPlbx3zQ/alSPTtqwMg5K219ZAySmxgBOpAqEPCMXzXbLIehQcH9rA+HsvtG8/zwR/KvaSY1zwRLDqNBQC5tvZz93Kym37Cf5tNQYEy33ldOjU2Fh0YTHmUP9JUHkVVWvMWhY0WqpWQsHobKaY7qdPnaYDca5Bg+d4/tCRH+JSjvCUx/DxBCI43VsCphYELvlkG2z2OHvEUjPcHnuJjQkmq1lPh9vPNuPYbD9uSei51SoHOlxQw4rFK7LJlSyWF56dDXtq6s59UbBnbYS9ZsZrqIjGGrXH6+eJhAVIhqkd2jXWhyZv1snjekSNx/hzZ0HxckTB7kmEbnboIKHvF9hJVthHQ02h9lS+/itL3qZGk1q8hixBtxM2JDNgWo2Rmq4okcBIFPZVl3JrZB4HDI1VP7tS1pL2Xc9rr6N5Vu0COlCUL63E+Z9fCnmsyTY1WJr78I+nswJv77vvHX3NdV+fMLjIG6bHvw4ZTaixQBm9ZqrvsesK81C2lKe2x74MOigLUSafaDy2zHjO+h2oXG9JV47KBKrazCn59DGYmeFF65FvY+hvLgCtcmsfSHyuQ14QzwwR1oHcmF4L5tw9rZ+lTYOdVm16b3NUHU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39850400004)(366004)(346002)(396003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(9686003)(6512007)(26005)(33716001)(478600001)(6486002)(4326008)(8936002)(5660300002)(8676002)(41300700001)(86362001)(2906002)(66556008)(66476007)(38350700005)(6916009)(54906003)(66946007)(316002)(52116002)(53546011)(6506007)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BIjAAyk2J5x4MViFWxmYX4FkKx8ScfqHrmO1XC2SK2apZOUHInKDkgUj6tTD?=
 =?us-ascii?Q?jiY4WYPwQJsXqLWmz6pbyeNvymbF0k5RNEhS7QYeaOam5hjRpwzBsD6OxMfT?=
 =?us-ascii?Q?E9eg0uDpHmNex7IEKY+gUtq+hMBjEBgjyR4qakJiIdutkw2BNOmoCqZZjm0G?=
 =?us-ascii?Q?tBGPXq2e6OtlCZr7a3llodKfObvHBRkY6ND6EvoZXeA9yNYhCH7hc0zP71K/?=
 =?us-ascii?Q?AylMsa0JmmiEJTYFUYJNeChp3NSyaVDRQgjFLQ1wax0NRvPTOh5Ng4VbwhPW?=
 =?us-ascii?Q?2PSFHPTIerPQc9fSF+H2lKhmt+Oib4sxtIfxJQ/RoGPGVvYvuMz03sbr6dIe?=
 =?us-ascii?Q?qbiydDt3LjPjy/s9E0FE08bXzWvSeCD7zHkenm7r7r4Z+mbcrI8MAn27jOPC?=
 =?us-ascii?Q?cynIgvRdK7tTjhrp8236FhjUPle6CqA8POQ2yPL9Ma0t5/+Sn8UBMuwmHAMg?=
 =?us-ascii?Q?zvRzwQ16Feew64EbQ1K2h2DDsrGuqntWEdGbwo4B2FzAOzkQTick1nmeNyfc?=
 =?us-ascii?Q?RjYQ1uh6CowS39NpoDJQqGH6IW+iipze+/X4EMYIohfncuP8Ad39Z0RBi1ky?=
 =?us-ascii?Q?LEVxD4UrCtbjdUXmDWokXnap2JsGEh6vPx6yoHBsaEgnyVuT66wSgqyWyTzP?=
 =?us-ascii?Q?V4458gKhYs/N86ic2BnV+l5u+BXEIfFBbo9vBdhT3Cq7+5qVthDKDlPrihyi?=
 =?us-ascii?Q?/FQgDZ5gNtch5DLbZxq3J3Ysr5K1EA6K20thIoHQ10ruknMOc6shMadolpgI?=
 =?us-ascii?Q?Ag6obQo7KcRmhPUMO8klct1P6AjoPCuYI1z4r4jTKdDwPWx9/yeQZTg2CKH8?=
 =?us-ascii?Q?BK3By0pthDIVfXSqlXuh0FpkAWBa0OWVxA9pBoED59+JapwWhX425SDC1pOa?=
 =?us-ascii?Q?/rlZWkZEpHrMU1gaXDooYQFcei622EP6O+xy06e3Ep5OLgPSnywohkNQxqwC?=
 =?us-ascii?Q?oJp8wUzMG42I9jQ2ysVe+QXVUmjXUJhozbEmanDBkFzk2Hykto5yRSGB2Iq5?=
 =?us-ascii?Q?5u2mv3klwpE7g5fWiM//1TtZ174oLbFI19Z70c10kBOK27jdBW1cR4RTXHF4?=
 =?us-ascii?Q?MykFB1T5hZCQQcJvI/FN/ajBchcr4QWVPrNg1kSVNnZYP64dWMATSxToyMzg?=
 =?us-ascii?Q?jcxsNLCEeAl8h2oaDtQzc+bb5hIzEH/C692PIEZ6dSIMrnEoeYzR8Bf6wE+1?=
 =?us-ascii?Q?i2/Qr4+DusITD3ToNBxtW1idN0Tvv53RdQ1Y1BwV7Q0rGz1PgEcydjtfsaRO?=
 =?us-ascii?Q?MQKtC6I4GbJneenFPT/ieySDEJ0d/6oTlBOFg5TGuX7W9H4fKT/YK1E1HFLs?=
 =?us-ascii?Q?CVl7sa42iRFPIEuf6ep3vOqow1pcLff2+6ZBWiJGlV2TvkybqXUwS9LyhJBO?=
 =?us-ascii?Q?Pf2iHIDR8NSEVxNQZjEi5TXhqNraWWAn4g3T9hsLJUzn+iGU2PNOJkOHFahG?=
 =?us-ascii?Q?Ab8aa3hvUWtbzSaxzORlYs8+h3QgAb7zIDdSd40w09x161L7rlWpG3HpWqgi?=
 =?us-ascii?Q?9K9Jm+VpkJhs0jiw/vRsWMhSvDBQTPOG6/ILz48li43rfyJGzOCcY9Q4AMi0?=
 =?us-ascii?Q?g39MMNyettiOFWvH8VWyYb3d0jOk+wjC1d2W42AXnw7uIGxaWhcQx266r8ek?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d525f548-23ff-4e64-046d-08dbde98c709
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 07:19:56.0534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADqhA0O9iqKJ6XF694DmjRhEZq1XJXFxl48OmwG1qr9sJaCbXdx+ix4UAUvKAO0hmjdYuPRTGPZHrJrnvpAhbqy98n7z5Edt/6hxZZ0dPAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB6380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 08:53:18PM +0100, Lino Sanfilippo wrote:
> On 01.11.23 07:44, Crescent CY Hsieh wrote:
> > @@ -1371,11 +1371,26 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
> >  {
> >  	u32 supported_flags = port->rs485_supported.flags;
> >
> > -	if (!(rs485->flags & SER_RS485_ENABLED)) {
> > +	if (!(rs485->flags & (SER_RS485_ENABLED | SER_RS422_ENABLED))) {
> >  		memset(rs485, 0, sizeof(*rs485));
> >  		return;
> >  	}
> >
> > +	/* Pick sane setting if the user enables both interfaces */
> > +	if (rs485->flags & SER_RS485_ENABLED && rs485->flags & SER_RS422_ENABLED) {
> > +		dev_warn_ratelimited(port->dev,
> > +			"%s (%d): Invalid serial interface setting, using RS485 instead\n",
> > +			port->name, port->line);
> > +		rs485->flags &= ~SER_RS422_ENABLED;
> > +	}
> > +
> > +	/* Clear other bits and return if RS422 is enabled */
> > +	if (rs485->flags & SER_RS422_ENABLED) {
> > +		memset(rs485, 0, sizeof(*rs485));
> 
> Why are all flags cleared but SER_RS422_ENABLED?

IMO, RS422 and RS485 are distinct serial interfaces. Therefore, when
RS422 is enabled, the other RS485 flags should be cleared, and vice
versa.

> > +		rs485->flags |= SER_RS422_ENABLED;
> > +		return;
> > +	}
> 
> What about all the other code places that check for SER_RS485_ENABLED?
> For example uart_update_mctrl(), uart_suspend_port() and uart_resume_port() check this flag
> to decide whether to set the modem control lines or not. Should this not also apply to
> SER_RS422_ENABLED?

After reviewing the code in serial_core.c, there are actually some codes
that check for "SER_RS485_ENABLED" flag before setting the modem control
lines.

It also appears that these codes can only be done when disabling RS485.

So yes, I will apply "SER_RS422_ENABLED" flag to these locations in the
next patch.

> 
> Maybe it would be better to change the meaning of the flag: Instead of being a substitution for
> SER_RS485_ENABLED, it could be used to mark a special mode.
> So if both SER_RS485_ENABLED and SER_RS485_MODE_RS422 are set it would mean that we have RS422.

RS422 is not a mode of RS485, so I think using two flags to represent
them is much more reasonable, even though they are both included in the
"struct serial_rs485".

---
Sincerely,
Crescent CY Hsieh
