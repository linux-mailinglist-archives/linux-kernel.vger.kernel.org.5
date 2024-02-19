Return-Path: <linux-kernel+bounces-70910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A1859DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0679BB225E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE2B20DFD;
	Mon, 19 Feb 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="h4EZeSEy"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2123.outbound.protection.outlook.com [40.107.6.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659720DC1;
	Mon, 19 Feb 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330368; cv=fail; b=VQ/UMcA5vf8/oLkZ4F2RC+Suhpc/WIxfQVf7HkjtQ9VSyHMHE/UZ3fFwJrFR7WLIayjUTTYr6qIULbVvvT9GuF1cgwzNcYDKqnDzN+b0TL2m5DEQI5fxGXEXmSE1MswbraqHEi6ZytY63ZmFVlbwp7px59xiod7RVmKJeIOpYCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330368; c=relaxed/simple;
	bh=KIuBD+KQU3GeHPUIegJdxm5UzH4H28mmDqFj/gf/W48=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DYWK5yQIqsdKci6PdyAT5bQNdz0f/xC3zoiqZvptFLjRy5dluySsos8bn8iBebAc5xiXy1ex+brjCEIM58SW2Aggz+N84rMgPe/ICf7NOFkEaUWiN8GW6sIOCS/N9cfc6DfGRHNQuNyAfHwsexp2+DuMpObU4NFxo0dhZxowTYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=h4EZeSEy; arc=fail smtp.client-ip=40.107.6.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+gAWYOv/4XNo9PD51rY95FZcl1JjhEw3n7DTFcoV+bFa3l2++Dvk61Lus7h93xGT6zTR+GesUreBWWzpjn5pIRnFrxLYS0Q+K4Bv2l8BVOP1nTjrp/lDFJmWWv3qJLmBNo6CAKF9WFaMn4j0AkKewF2FuHrAjLKoorBS50NliwlWUdfh0q69wnJ28JRcF7rPMpgBHyPn6KA2Us3avVzvu+2dU0YPx7YnY+NjhHWG4oSjAPues6XhZFupLHcGoLbrgW53Hfl32xoDsGykthA+9/0q8/EpI5KQhCUFWw2Q0dWcEgfczYH+tiKOrOlc2GxHZ/NkYs8kPfUvfcyjcIkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRNkPRoHGDqz9GP/FPMsheZtsGRepR+OkThaXGd6xT0=;
 b=mXvtJBtLmDRREafloKXb4PzMvZ9++MZr6LXbSsmpwwLnJ2VGHXXVS3Q4Mle10hDDqs+1Tdqd4/dTLewRkJ4PhubzqGMuHcSWB5xbBJ14xLTQc5ZZeHMdqbY9Vl1v7c7QTQ8bO5zF/wTmb7Gi9yk+aioVwgOWxVHJ7VR8Tcq+rLEYtvLbMshwWcDqRhh4MgXpyaus8MRItz3pPnlH5V7fVWcFQRLtwm5j82fnY9ukQCC39W6R755HlNPyniEha0THXT8VNIX4hc/ky9fy8iTimDvQk2Pbp/GkzL8qMG23+LTBzq93wRD0S86iJFSMw4t6t2kfzPg+vnOpuO3JC1pipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRNkPRoHGDqz9GP/FPMsheZtsGRepR+OkThaXGd6xT0=;
 b=h4EZeSEyVdCsTmdYPO6WaMA5N6p5WYSWZf1tcKkU1qm7wlF8q3jkshEkVNBvH0gQgoSd30yciEa8N/04rBevynBKFXVkPQT9pnXvqGpMMgIUfLtJb1gSzmRqTeQ8Pl/lJjJgyDQj/V08K79s47/B7KRZgwUqHbwN4I7hSv4uyfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VE1PR08MB5664.eurprd08.prod.outlook.com (2603:10a6:800:1ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 08:12:41 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9527:ec9f:ec4b:ec99]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9527:ec9f:ec4b:ec99%6]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 08:12:40 +0000
Message-ID: <33a0db95-06da-48d8-885e-0098586f6229@wolfvision.net>
Date: Mon, 19 Feb 2024 09:12:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/4] Input: support overlay objects on touchscreens
Content-Language: en-US
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Bastian Hecht <hechtb@gmail.com>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 Jeff LaBundy <jeff@labundy.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::10) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VE1PR08MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: c09e800a-fbf8-443e-2695-08dc31228a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FAKLl4WEGaoN2JnnTkMYIOCcS2Q/b/ArB8Rl6J+I6LaCnnAm6c6RswVsGLZ3defDkS0tsa2uwkOh9P3iCmwa9YLeTCrmQSxS42IxR7bv8bJ7lHauzWbQ9yO51E9jE11s3bDjU/b4rkNpCG9znMzqHZYhN7gJA9aFzgwEXuAAV4H1yEjWy2WaCMGAO48WOKctgvjwJZWA8YgFRfl0VO5MDyg92hAALSfSme4UCYTgLSxgmRtg/kudkJt82Ec5ZoCB6Zkd/ttDVlwElAe9bt5nC4WT5zNALrs4J/RuRKzJEQLQ2/Yc0AZeygECkEA9SDE10klc8pzrVe291xqIAlr2f06pJ6cYA0Ojn0F92FL4L6SWFj/lChAsKwG5uEyNfb+hDd73N8cabA0oat/R2l4+f825ghDBUT6mVfHH8tR4T61FerD9UDJFsw94KD/C9qzh/iD1VmSKW47WP+AHCsg/2YpxuOMiyKeHzef8y/yRASJAwfoe4NFsJ2kuxyps3J2WUi64Ivhwt2JoN0r6FIu/hMvbtR/gTyGN5nIUakwy9YU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(66899024)(86362001)(31696002)(36756003)(2616005)(110136005)(41300700001)(316002)(53546011)(6506007)(6512007)(6486002)(7416002)(44832011)(5660300002)(2906002)(478600001)(4326008)(66556008)(66476007)(66946007)(8676002)(966005)(8936002)(38100700002)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkVaNERIekJWWjlXNGdEdnhBeUYyUDRsZ1pUUmliM1VtWVVId2lhakI2OFBE?=
 =?utf-8?B?Y1l1bTZlOWxBeE9XdmFHTWJDeDdTeGhGYlRsSm9Mc01KTVRWL2dOWWltc1dX?=
 =?utf-8?B?dmNKZ01CQ01laGtYeXRkUENZWm1TSzNQOXdzNjNMczhQUjhEbmdOd2VnZFRo?=
 =?utf-8?B?RmNFWjBGZFpkNjBQbm50aWlBUkcwYVRMcDhKVHJEc1NyZk02M2hqMEJFcU83?=
 =?utf-8?B?eHlyMVEyRXJPNk40Y1kweGpMWllOQzJxTytvTk43clZ0em5oOHNnWXU1VVBH?=
 =?utf-8?B?UXZzZm5sd2REVWYzeEQxWnd6SzRGcUNuZ3NhKzdMMXBTODA0QlJBTWd6VU83?=
 =?utf-8?B?NGQzckNlaE04eHhMaU1ZeTRPVDVOa2RLeEZrTUhRYVNsVCtObU1IeHBYcmJ4?=
 =?utf-8?B?OGRJbllnMzBmLzRwMVpXOVJod1pNbUpuaE1YL2UrN0p6NUhjcXZ3V0FtQXlL?=
 =?utf-8?B?ZU1NcnVLZnIwOGovRTZqeHJSazJUY0dPT3lxdVcvZGhtbllVTlFFbHk5Y2ZY?=
 =?utf-8?B?N3c4Q2lNQUI0NnUyTXhMeWkrNHBLVldlemxDeXQ0R1VhSDU5K1NzZUNaWVlF?=
 =?utf-8?B?NEFQbWFqcTdjRTFNUCs3ZzE5b3g0akNpQ3NEMjJDV254VEcva2U3aGdrb2RB?=
 =?utf-8?B?TFdYNlk2SEFTM0dYMHV1ZUxIQ2NRVUtGcFE1bFFCQWNxd2JxckI2dVpqcVAv?=
 =?utf-8?B?SkJCTkp2bWM3czg2R3NLRjUzeXFONnptS093bndUdlRPYXBneGlXcjRSbFJq?=
 =?utf-8?B?WC9QSWYzd0hMK2ZBRzFJMVhXVDBsL04xSnBSNzBpZDVPVmtXRFU5aCtrWTBO?=
 =?utf-8?B?RnVNSjd0TjRnU1B0ak1HZXZsNUFsN2grcFVxSUNqOWhwdlBZdllzSGlhdkky?=
 =?utf-8?B?MnI5TWw1UmhidzJPYkg4TmpER1BWUE9uT1ZWeWVFb1M3cm1RSS9YT3Q3RlhD?=
 =?utf-8?B?MFNza0xucFFtTWo3UUNQUXYxM1llZkgxQkthcUpOc0dRRlNqQ2JVZXZsNEFQ?=
 =?utf-8?B?VURZS3o1NXkwdmVnUmdIeUNYVTB0WVREWnpERmtCT1BiZ3BDSU5VaDNTRWNP?=
 =?utf-8?B?UEM0WGhMdkIyM052S0lIaTBLMCtoZ1NlM256TG0zeEtGZ1N6Yk5HM1UyUFYr?=
 =?utf-8?B?ZlJpazcxR0wwNUo2bHhkazNKZTRoTUhMZ0xWcFlCSlJObklHRDI0Rk9zWUdr?=
 =?utf-8?B?dHQ4Szk5NE03cFh3eVk3YXJTeTNFeHdaRGN6OWR3TDBLNDQ4OVV6em1HaEN6?=
 =?utf-8?B?QTRiOEoyVzNyTldCMkhaY3o3bVY4aFdCemR5WjNZbVBjWS8rbUIwWEdpMGIw?=
 =?utf-8?B?cXNIL1VjU0VlSWVLd1RaQUdjSnVFZm9LV2pBTEJkVEhaS0RuUFBDdi8zVFg4?=
 =?utf-8?B?Q0RVYnR4V0haT3BacWZ6ME51UnUrczJ4WjE0UFBDNWZ0QWIySzdzd3pvemRj?=
 =?utf-8?B?ZXd1SWp4N01YeUtJRU5PanJMclpjK3RNMHlzemtRR09SL3RvUENMZVcwdy8r?=
 =?utf-8?B?SU0yOFdacnpBTng1d0NZdHZGdFpwZ1NIL1hyTWx6ZzBqVmJoMVFvL28wMHJY?=
 =?utf-8?B?MnNPZS95NzZLb1BtbFkzbDBGYXdPOTBLdkhxODdJSlBQd2J5aklkVmdxWW1C?=
 =?utf-8?B?bnhzQnIzRHNzSHN6enZEenJxZnJRWGNSQjQ5aEp1TXhaLzlTcS9RVGJ4bEVO?=
 =?utf-8?B?azFZcXh5N0ZGdXA3M1c2bnFudFZOT0MycmpjR3RjdWpGcmpkQzVpWnBvU2NR?=
 =?utf-8?B?SnFQV3ZRR0J3aFBEV0VtejBYVUJ6cWsrWDhxNDdKVHVHRVBsWXZzR0lkQk1z?=
 =?utf-8?B?cENKOWluOEJESFp2N2xUeURtR1ZpTnJUYVlKanRvTzJBWHVaSTN3OGJEWVgr?=
 =?utf-8?B?YitWdnFmVmQ4YU9CR3h4U3JyL2FSeWRpUitBMVI2Sk5MMGUxTU8vbUdaOGVW?=
 =?utf-8?B?OGVZeTdPWERxTFhNSkRMN2RjaHMxc2pwZy9sV1VPR3Y1TmhDcHI2MmFJTURq?=
 =?utf-8?B?d09URENpNFJrTGZwRjl4SkNQNFlxL1RzbFlhWk9INWsvMDFRdzVoNDU4eWdz?=
 =?utf-8?B?UmFGNDU1RWJlVDRITTExZUxXKzNxZVRqUEluTFdPTjVCaHpoZFp1eEtycm1w?=
 =?utf-8?B?QU5udE80NVpINFNaUmNNMmgyaTNiMCtJYlMzSGJDVkpnWGsrYnQ1YTVOMEgx?=
 =?utf-8?B?WEVzbEF4bTM0NngzdXp2ZUxpMUNsamhtTzlVUmVFZ3Y3dWVaNDBtVVRXeFZq?=
 =?utf-8?Q?cNOSGTminstwpzbMw9TnSbppZkXw8kbV6zmGEoVo14=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c09e800a-fbf8-443e-2695-08dc31228a8f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 08:12:40.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PgHoxhX46iTvvTGGSM81ueSuQTa5N/LSRm9R7NhdDJ8AUYt4lBAHNzez6zZnvai53+6jP0UR4/FWZExRSvhAf3GxfhbCzQRq/Ys6jFWJaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5664

On 19.01.24 08:43, Javier Carrasco wrote:
> Some touchscreens are shipped with a physical layer on top of them where
> a number of buttons and a resized touchscreen surface might be available.
> 
> In order to generate proper key events by overlay buttons and adjust the
> touch events to a clipped surface, this series offers a documented,
> device-tree-based solution by means of helper functions.
> An implementation for a specific touchscreen driver is also included.
> 
> The functions in touch-overlay provide a simple workflow to acquire
> physical objects from the device tree, map them into a list and generate
> events according to the object descriptions.
> 
> This feature has been tested with a JT240MHQS-E3 display, which consists
> of an st1624 as the base touchscreen and an overlay with two buttons and
> a frame that clips its effective surface mounted on it.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
> Changes in v7:
> - General: return to a single input device implementation.
> - touchscreen bindings: segment instead of button in the label
>   description.
> - touch-overlay.c: define button-specific data inside segment struct.
> - touch-overlay.c: remove fwnode_property_present() and check return
>   value of fwnode_property_read_u32() in touch_overlay_get_segment().
> - touch-overlay.c: simplify return path in touch_overlay_map().
> - Link to v6: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net
> 
> Changes in v6:
> - General: use a single list to manage a single type of object.
> - General: swap patches to have bindings preceding the code.
> - touch-overlay.c: minor code-sytle fixes.
> - Link to v5: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net
> 
> Changes in v5:
> - touchscreen bindings: move overlay common properties to a $def entry (Rob Herring)
> - st1232 bindings: move overlays to the existing example instead of
>   making a new one (Rob Herring) 
> - Link to v4: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net
> 
> Changes in v4:
> - General: rename "touchscreen" to "touch" to include other consumers.
> - PATCH 1/4: move touch-overlay feature to input core.
> - PATCH 1/4, 3/4: set key caps and report key events without consumer's
>   intervention.
> - PATCH 2/4: add missing 'required' field with the required properties.
> - Link to v3: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net
> 
> Changes in v3:
> - General: rename "virtobj" and "virtual" to "overlay"
> - PATCH 1/4: Make feature bool instead of tristate (selected by
>   supported touchscreens)
> - Link to v2: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net
> 
> Changes in v2:
> - PATCH 1/4: remove preprocessor directives (the module is selected by
>   the drivers that support the feature). Typo in the commit message.
> - PATCH 2/4: more detailed documentation. Images and examples were added.
> - PATCH 3/4: select ts-virtobj automatically.
> - Link to v1: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net
> 
> ---
> Javier Carrasco (4):
>       dt-bindings: touchscreen: add touch-overlay property
>       Input: touch-overlay - Add touchscreen overlay handling
>       dt-bindings: input: touchscreen: st1232: add touch-overlay example
>       Input: st1232 - add touch overlays handling
> 
>  .../input/touchscreen/sitronix,st1232.yaml         |  29 +++
>  .../bindings/input/touchscreen/touchscreen.yaml    | 119 ++++++++++
>  MAINTAINERS                                        |   7 +
>  drivers/input/Makefile                             |   2 +-
>  drivers/input/touch-overlay.c                      | 250 +++++++++++++++++++++
>  drivers/input/touchscreen/st1232.c                 |  48 ++--
>  include/linux/input/touch-overlay.h                |  22 ++
>  7 files changed, 462 insertions(+), 15 deletions(-)
> ---
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> change-id: 20230510-feature-ts_virtobj_patch-e267540aae74
> 
> Best regards,

Gentle ping.

Best regards,
Javier Carrasco


