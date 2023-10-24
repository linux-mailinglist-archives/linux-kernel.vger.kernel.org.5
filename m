Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC0C7D4406
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjJXA3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjJXA3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:29:07 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCD52133;
        Mon, 23 Oct 2023 17:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9OoPHBeSxIvloEDjeyCiUeAS1xjm3uucRG2daQ5AW3yEKFmRZokl/1za0cp5GeJYhESCtfpTA1kMLsQlwV6MlmE2Zf3GjWc1GLolweIJ7YwU5lCWrVift+ySB8A9Tmc1I1rcokHydGqgquU5OUR7igxfEUZPinOevpXC5alLWF2i3rEtP2+1wezICdxqrLP6Y6p8hDQ3OgQXznutCZ5HSnncEC9s2yVMZUmj2uoKJoJR4F/dPrNUVmppT+MyGo+waJ8nxIJ1tXf4vna6nGqoJPBWR2dbYWpijWamac5jPppSVyuXq2NPzsydZ9Xkut8HDQcVag3Tm42WBccJb4lIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhEryupyE4ELeYFogn8vypDD8D0FlP7jTxmfxLEq6Rc=;
 b=YG5QJ6kKk4OJXwAGf/Gi3E7QKn/qc78awdDSqLYFa3grte4YuEUEdqYArBbCUyZj8LX8F58W3O2pvTjQdhy7DQFGsTc/uB/92nYB/njoCJYb2fPxyaVYczft9ANKzhFhi8FlXtMqqdyZWtaf6V7T4QfaFczY2kwDBmdml5xlXKouI+iTLRlBRMOJ03MQtxPnkJhz9KzsGXod5OuN2mRNyDXjBfLPrGTsoduIOFMpvFRrK+nylGcm0rHyittGZBMYv9LjMXM/+nexZtCla7eVtzikZ90RJhqQEWFt9Qa3YZ0O+8dXhkk2iXA62J5VKPKonJaAkHGR9aq3QyhPhbE96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhEryupyE4ELeYFogn8vypDD8D0FlP7jTxmfxLEq6Rc=;
 b=DodGk3iiL/YCdUpIIDjFVq0Y70wAoJyXopSnTpwprUrNarh4QOSOAcy1w7v3WCbRV5WV2oBn8AIvLExXNCKLsJDGxN8UBFjHIBn3ZDk9Gxlv3K840iYUxwovAUZLuNxmuqJJAHginaWalCDQ93/RS22O3pcSKicQlo1zq/OqNHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by LV8PR08MB9556.namprd08.prod.outlook.com
 (2603:10b6:408:1fb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 00:28:35 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 00:28:34 +0000
Date:   Mon, 23 Oct 2023 19:28:28 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
Subject: Re: [PATCH v2 2/2] Input: add Himax HX852x(ES) touchscreen driver
Message-ID: <ZTcPrC+0K1unNPIv@nixie71>
References: <20230930-hx852x-v2-0-c5821947b225@gerhold.net>
 <20230930-hx852x-v2-2-c5821947b225@gerhold.net>
 <ZTVoiklUJaDn5576@nixie71>
 <ZTVuqW7oU5BmPzTS@gerhold.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTVuqW7oU5BmPzTS@gerhold.net>
X-ClientProxiedBy: DS7PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:8:57::19) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|LV8PR08MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: ddaac6c0-948c-4e48-3d1c-08dbd4282868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBE48UP9z+D1LMqmBXII0/CWtAphGv/tVlkJkNmCYp691Tdpy9ul8arajxnROuGhsghUt5DnkAPpPyezFyBnXj8Ah26WzDWavWRdNAQJTzQIiV38fVAfSeA/EOo3D7Zejl55U0vcREJFKVxeXcVPttJ10lMQAJNYBpP5/O0I9xamotFX4UbDlkkCxUblUM8zKoeu3sFBFfPxLBJ8y7XSrlr3jBmewgAwn1r+y5ceLiyLSIAPorlGvCDQuqLVmuotvVw7oPf2JWbNWOsagpNnVEPEsQNzm0ATnvMGrFw32E37XAvcTLaay7mIrBC2Tsd2AagpUROsTZSC8d56q20BK0w0ZwIEE+3J2Z031v78X9krR5PfMtDLx6BESIDnQEQOhmYVr+aQ9v+ubkPnDzabBBFHzeSQ0PELF+GbxQgWmzdNnlzxnFQA3k5fFvDrJC5Vy8Nlq/dxEMz7g8ANtx7u4JYmTrjG+CUwUCu+lj2w0rwDU1XM61ONao2YOUocJnd++3Txk/psjrWzg8yT//t3V4p7qnFqICvZ3WDC+jqTZnBPO+rtqHQXKns2lSkkj4SBzS3CQva21Xing2la2yO4XtcYxg5sBNV8hQCw+jHJQH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(346002)(39830400003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6916009)(2906002)(5660300002)(7416002)(8936002)(4326008)(8676002)(66476007)(66556008)(41300700001)(66946007)(86362001)(54906003)(33716001)(6506007)(6486002)(478600001)(6512007)(6666004)(9686003)(26005)(316002)(38100700002)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dGUu2+nAphGCY0TliGciEeNwergSZHvZZIHBHD1lUYBb9c2EzkiPbh8hPfu/?=
 =?us-ascii?Q?U5i5jog6TKkDg/8Xzzu86MpIsLOwsY7vzGOtx0UYlic81vEQtCKyQLtX3aoz?=
 =?us-ascii?Q?JbXCO5vn7rZIvYrZGQnTuK5Xm7mGtgvzl1gQ0FBsye4dja1iQsZt1Ty1Owfh?=
 =?us-ascii?Q?q04YE4qcDVodaCTw7Fl9QTZvMUc6ggJT7+Tt9Y/HICXKHvD+wWyenzT3ibXs?=
 =?us-ascii?Q?0lEnS4NNaS+6lwt5kdXMRi2XRT8oiGGKhDxOQg3nF8RMdpPzdcY3D1sXRG25?=
 =?us-ascii?Q?d5l/TNPpcG25U4iQuTWWKyg4L/aj7wCfAHyd1AL++Y1CyUkUHIY6YmvDw2ii?=
 =?us-ascii?Q?MO2JM4QehIx+yJwdsROyWRQKxwzN4nDmO5/gnal9s3hSFPXczzBxTePfkrUp?=
 =?us-ascii?Q?CyJWxGL+/br3UgVCbD8AcUq8QVwz9J9KaYGvo5jemO6R+LxcG6oIJoKths2x?=
 =?us-ascii?Q?94W9Rr38zo5jazkcBoqK2YA9K6/lkdXH3DITk1FPGJi7X7q4r5kpfP60fi2Y?=
 =?us-ascii?Q?lTZGosrvEKBuwvjHSCHjzE3hQpDNfq52GN9/EV2c/xdNPXlZb2B9DRBiRcZV?=
 =?us-ascii?Q?jtdI9DnHpyZ6ibVmeXR/x0xjZn9Pk2Z4zyFRBvc3KBeJ6ymzZ4wyNz5MY1XM?=
 =?us-ascii?Q?MOpK7UaCRZyJ55hsDj09Ma0UG02iwdoMk4H2G+eHrY/JL9Wc8da8W03C+v3T?=
 =?us-ascii?Q?0Goz168gkZM5dcnc9ZDoPK8fH37ARmihBtALUKNVci7Klq1Pf7aDVcNllqmp?=
 =?us-ascii?Q?nnjlV6wk5zjrgbiSZeJ8x3qAuxrq5ETdSMzTENtfi7ocVPdGPORLHtvnJ/SA?=
 =?us-ascii?Q?Fc8ZUxK1dtiWl8hyPQlZ6yXph/249eKdYDDjBJLbNmNymzGYVXb6ZjeDHi0u?=
 =?us-ascii?Q?EorJptL/6OvtUbCY5XYg416GyZx2kiQSkiEUSLLJjIwXkp3KuXHWIPEdAnUn?=
 =?us-ascii?Q?B0dxSr+KiVbs23KU/r9ZnQChhX1LWy1zRnkaL9PRgscy/7fWnVmd65WErPAU?=
 =?us-ascii?Q?n7ckdwQM9/s31F4haDzcGo+mP/Hl4iJLPtft3NY0Q1LeQM1yIylGOU/0ym0Q?=
 =?us-ascii?Q?A86Z8VMJ/hA9enFbErKd1qpHQk+3PVY2FJlXubxNKaUFFXNEtfdRfUnneuc8?=
 =?us-ascii?Q?x6GPZMIvVTqcOTWfieknPgNxx27C3Enge8Q9AgQAmAcAREx2w5//ZVTHDW56?=
 =?us-ascii?Q?K5f8D8O/aGZYs6bj5VXhERQIdcK4KZmtWRVFgrtqPwxXyiCoTg6xJBhAZMvT?=
 =?us-ascii?Q?00TLuGtNHztAj/5YWCaGu04MK9IZ4ws2lnOYe/ThE33cM0GSu5V3UeiQUlIA?=
 =?us-ascii?Q?Sg9C3zcf9YiYkTMRVH7aBLJDC+7ezo5YKUczpK4MsALWCD2GidYo8aGNMpkG?=
 =?us-ascii?Q?/hkhI2TR3N6WzchQJCmbpYMCJNxn74biaCoCWXKArscSUg+IpgIEWfzO/7wa?=
 =?us-ascii?Q?DuC9xrMMO5yEyf5ANkJpSEUfOg3AqU+5nKGDwOQ9uxw4EcRlE66rx/xIa4SL?=
 =?us-ascii?Q?cgIEwOly4y396z+SaFHOx5QOgVTojoizhQW4cnLDiLTcyimWxeGBL/4VghRc?=
 =?us-ascii?Q?fStvtdgdTvfeaGGXcPWjwpdGaLxlYbv6mbGeK1o5?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaac6c0-948c-4e48-3d1c-08dbd4282868
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 00:28:34.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwKI6NOPfZGkpk1Av4oWR0meiKf3UMXtwD/K3zGRGbBs8IP5gV52t1ETOTpM7yZ/XD1l2ibGl77aF+nJhc/HZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR08MB9556
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On Sun, Oct 22, 2023 at 08:49:13PM +0200, Stephan Gerhold wrote:
> > > +static int hx852x_read_config(struct hx852x *hx)
> > > +{
> > > +	struct device *dev = &hx->client->dev;
> > > +	struct hx852x_config conf;
> > > +	int x_res, y_res;
> > > +	int error;
> > > +
> > > +	error = hx852x_power_on(hx);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	/* Sensing must be turned on briefly to load the config */
> > > +	error = hx852x_start(hx);
> > > +	if (error)
> > > +		goto err_power_off;
> > > +
> > > +	error = hx852x_stop(hx);
> > > +	if (error)
> > > +		goto err_power_off;
> > > +
> > > +	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH,
> > > +					  HX852X_SRAM_SWITCH_TEST_MODE);
> > > +	if (error)
> > > +		goto err_power_off;
> > > +
> > > +	error = i2c_smbus_write_word_data(hx->client, HX852X_REG_SRAM_ADDR,
> > > +					  HX852X_SRAM_ADDR_CONFIG);
> > > +	if (error)
> > > +		goto err_test_mode;
> > > +
> > > +	error = hx852x_i2c_read(hx, HX852X_REG_FLASH_RPLACE, &conf, sizeof(conf));
> > > +	if (error)
> > > +		goto err_test_mode;
> > > +
> > > +	x_res = be16_to_cpu(conf.x_res);
> > > +	y_res = be16_to_cpu(conf.y_res);
> > > +	hx->max_fingers = (conf.max_pt & 0xf0) >> 4;
> > > +	dev_dbg(dev, "x res: %u, y res: %u, max fingers: %u\n",
> > > +		x_res, y_res, hx->max_fingers);
> > > +
> > > +	if (hx->max_fingers > HX852X_MAX_FINGERS) {
> > > +		dev_err(dev, "max supported fingers: %u, found: %u\n",
> > > +			HX852X_MAX_FINGERS, hx->max_fingers);
> > > +		error = -EINVAL;
> > > +		goto err_test_mode;
> > > +	}
> > > +
> > > +	if (x_res && y_res) {
> > > +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_X, 0, x_res - 1, 0, 0);
> > > +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_Y, 0, y_res - 1, 0, 0);
> > > +	}
> > > +
> > > +	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);
> > > +	if (error)
> > > +		goto err_power_off;
> > > +
> > > +	return hx852x_power_off(hx);
> > > +
> > > +err_test_mode:
> > > +	i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);
> > > +err_power_off:
> > > +	hx852x_power_off(hx);
> > > +	return error;
> > 
> > Your new version is an improvement, but maybe we can remove duplicate
> > code by introducing some helper variables:
> > 
> > 	int error, error2 = 0, error3;
> > 
> > 	/* ... */
> > 
> > err_test_mode:
> > 	error2 = i2c_smbus_write_byte_data(...);
> > 
> > err_power_off:
> > 	error3 = hx852x_power_off(...);
> > 
> > 	if (error)
> > 		return error;
> > 
> > 	return error2 ? : error3;
> > 
> > In this case we achieve our goal of attempting to return the device to a
> > safe state in both passing and failing cases. In the event of multiple
> > errors, we return the first to occur.
> > 
> 
> Right, this would work as well. Personally I think my solution is
> slightly easier to read though. In your version my eyes somewhat
> "stumble" over the multiple "error" variables and then about the purpose
> of the "? : " construction. This is probably highly subjective. :-)

Agreed, my suggestion is a bit unwieldy, and prone to uninitialized
variable bugs. However, I feel that duplicate code, especially side
by side like this, is also confusing and prone to bugs in case the
sequence must be updated in the future. As a compromise, how about
something closer to my first idea:

err_test_mode:
	error = i2c_smbus_write_byte_data(...) ? : error;

err_power_off:
	return hx852x_power_off(...) ? : error;

This is nice and compact, and ensures that errors returned by the two
functions are reported no matter the flow. The only functional change
is that the _last_ error takes priority; but in practice this does not
really matter. Normally if one I2C write fails, all subsequent writes
will fail with the same return code until the hardware is recovered
somehow.

For the corner case where the code jumps to exit_test_mode with error
equal to -EINVAL, and i2c_smbus_write_byte_data() then fails and changes
error to something like -EIO, I don't think we care. After the HW issue
is fixed and all I2C writes succeed, the developer will then see that
the number of contacts reported by the FW is invalid anyway :)

Side note: the '? :' syntax is just a shortcut that sets error equal
to the return value of i2c_smbus_write_byte_data() if true (failure)
without having to declare a temporary variable. If false (no failure),
error is assigned to itself. It is perfectly legal.

> Do you mind if keep this as-is? I don't have a strong opinion about
> this, but a slight preference for my current solution.

I think any of these three solutions gets the job done; please choose
the one you feel is easiest to read and maintain.

> > > +}

Kind regards,
Jeff LaBundy
