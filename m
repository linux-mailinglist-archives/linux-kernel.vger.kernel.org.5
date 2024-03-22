Return-Path: <linux-kernel+bounces-111303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F4886A73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B29D6B26AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0573BB21;
	Fri, 22 Mar 2024 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="f7HhVTd9"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2181.outbound.protection.outlook.com [40.92.62.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F337144
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103638; cv=fail; b=sL5IFgeRV5H5XI94/V1fj/GFqKXPFfNv3w1K7Gco6j+TU7Vd08heQhkRxk3XCepjwP/dmN4jkpRQfONc/uTDZUQ+FOyq5ScDia089yW47xacM835d5+MYpptVP5ocR5UBS8vzvi7ofAvBYyiiHqtQg+3k4H1K8xT9n5GwLVpZVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103638; c=relaxed/simple;
	bh=5LdQb/DSMwqo73pj/c7IlThVCFpa5lmRXlQHwKZ7Eno=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hAPdqxuPJXx4/4hN9WTxmHnFcWIf41lPJ3w/L4Ghp55d9/q8NwaSKc4shUbSKymdQkf9cj4TYFZOvk4PTx4w7yMY6eVRyVpsgEH4FG7Csr7/7WPM59YHnKxkAfb7MU77vzT6b82IXhOww7p5C4wVw8J9sBoLLRT6fEoiD9C2tIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=f7HhVTd9; arc=fail smtp.client-ip=40.92.62.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpmT/uRVgPdw6RT1n7Rp7I0/VoHH+38c6BCe58tMghD0R63y9LXrXNJEySatXNc6nFpaRsMC52bOfSMyTTCLLg6FyIrIGgNoRg/+VciJQ3Nzmv+ci35aInzfntcIdKmT7Rjrb2wWy22TaHsVQgQqxfaa/TpmTv3aTIrgB8ZfNJw2TEelrCkLLVetkkzUJ3YHzk/DB8QEL5E5kHtS1NqbE/90tBq99iso8WB93tJvCCZ+aCHaDZWiM2Il1CUGS+sKrOlE8uHUe5WikHXcuYz1cvgSuwMGENubJPnR8JdmmW8AX6o920+iekxG6E72rpPG5TylkG3dA8tdO89rfIsZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBkeWwk8seb3GdnjApRGIVH+v0cqoDoqrp3i9hgzJMY=;
 b=RHaGSaBEu6lu1uu+8yuMfsEP6fRtlAdoEqiZ/E+cHZbo5oSK7nhO3CtsrlOWCjxlzka8XB7hH8OiwZm5NsR+uVVOdJtD28uWdbCUZJDG2AAsiyhWxXxqfuaSpdbqSXrHvARO1eRxKseWh8ojbu6V1k9huNMbyFnool1r5aYR0FIgIX5tGrZ8Q5eyvNeP240qeM03ocUOVNf/zD+p2uyjstJ6LddpvwaQiZL3qXY79xk/WZ2mhDRPtoNmBOW1crwVSfHwm+tkSm17+Re4koL0wwITxibMhLVDKnPQPbV2fCxOUP870iSBp5GF8ozjmrF7t5FjG69yGNkMtytyMcHj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBkeWwk8seb3GdnjApRGIVH+v0cqoDoqrp3i9hgzJMY=;
 b=f7HhVTd9x2wUYFIy8SvVaFUXcQZFVq4xPQ0/8TvYj64RVYE7o4HgpSQEb8NlF1Di6OoQLYwY+6kPaDPERZU687/SrISphT4nRwWm4CaWLpzVVdFkOjWJKOruGuTyPLOtC3UQz3yGSxlKay5hN5yMetfq1SODoKh8yrZo7O15Qe/Yk5aA66ia+FUQeF0t0wQvtSArFDUQm5NGrqvvAHfWD4RJLoZ9fH2SJjIxSK2iWvYWkZcTTR61Y2ZYmPxLQayy48jhFwqRHrBjnY0uak9FXFkqfsEx8H8Jqiyol0VdtSFaO7wamn3pYwBoby0RtXOToMR/WhRGvsU6GMEfCXR9YQ==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SY8P282MB5238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2b5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.30; Fri, 22 Mar 2024 10:33:52 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d%3]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 10:33:52 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Lee Jones <lee@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Stephen Horvath <s.horvath@outlook.com.au>
Subject: [PATCH 0/2] platform/chrome: cros_kbd_led_backlight: Automatically enable keyboard backlight control if feature present in EC
Date: Fri, 22 Mar 2024 20:27:57 +1000
Message-ID:
 <SY4P282MB3063CE4FBC166A68EDA40054C5312@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:
 [nZXZAf5mmr4F0RjJP0CGQplSw809dtN2wWVdgswvofqErzznieck3/iuFFqsgtnzrMGASh/YPb0=]
X-ClientProxiedBy: SYCPR01CA0033.ausprd01.prod.outlook.com
 (2603:10c6:10:e::21) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <20240322102800.1322022-1-s.horvath@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|SY8P282MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 684cbcc6-3ba2-499a-5708-08dc4a5b9175
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	75RqNLgH6k0UCJ1+2y1RwOki3FZEcjdDDOEJISIVNaPtwAfzUuCxIV//J7BgmRbEtJs3VdE7Y4vgc5mxDHVjS9lXKuyLeitn85Ysf3F76onYvMsY/04fAN5NKAxuEDqOSNWBW5vMMg97beCsVwQn+aYRi1VHXnRwec0iWncg2lyHBmRRmUbd7xFdZp68lXj8iU/hBNxFik1560N/na7P1q3Y4NgxnHLnuM29JgZGKDrHNX8Nqs8qoSBpdbgrKwzySvZlJZfIn37uubXSPucibs2H9OxSW3/zvhajMVR0FYvK0slydg+k4inbq9yOQwSCauT4Iy8XG1ddYm58pKsgeqptw9qiNZN5GLkOD6YCwGbb+2vtqOL9Mc9mbVSOL6eTolds2i6cpsIwg67fh+dr5SZjLSDh+JsqvfNW4zpMtjdNphldqqU4CcvR01Gdkf2TKU387WC6uYtbu2L1LEaXSqFEIR8wkTC+IVGq2gRZhAZXA9/9telz1qnQ+dJ3lM4U1sQ+B+SP5wFj7BFiLaNfffpPsI9MXmJEE2q8vp39jptpy8FvkMI10hVavj4Y0KXKs3//arJsXEUccmBtlTU77vKQT2Z2nIrv5vEhPgCAt7WIyW6gnUfKJbDPh6WLOdY+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yvdoBaflkJsW0HHWlN19fSjdwmtSgH7aSQ3FRnSvDn7drFpWOHz8Ow4aFX/E?=
 =?us-ascii?Q?OE4t76Qb1gbaWW67Z0nwLbWgsPAqAvRhObBOE7Mf5LLrPAcEG3X+p4j1cpJm?=
 =?us-ascii?Q?vJCvZw91rX0tbopAA2sAx8O8W3GXXHJ5J6DCdN5VsQxTqTpqdSCxEWT/PJvB?=
 =?us-ascii?Q?1+5Sg2rkfOZ/YuYJGWmpuDy7mipE6+bBBDQFNOf1H3wgFDD2txEpbXbgHDP1?=
 =?us-ascii?Q?jngbZUa3Rz4IwWvrIgk8l/T5eIpN6zwV7QL/jnSeK1o24N7/JKnsPzYrNWpp?=
 =?us-ascii?Q?ogtpAeTkfJQ9ofrNaFYTQBooKOf7HRAczxcwcrVeWfhKuDNyjgB1D4Nj26Me?=
 =?us-ascii?Q?pWVvWXdSl0SFolSsLZvlRrP5uysPlQTAsx+1sfFD93pX2kh83M13P4lBECcx?=
 =?us-ascii?Q?hTnOmN7DOx2YwOluEnltPqWW5aWafU+VvrQLogHISzDr2aQQD5NyZGhuSNnc?=
 =?us-ascii?Q?Y88Bet0kzdS++CfHWVZyuDgtBHA8UW1SO3wX8MM0axPShMRby7+ob/mccVfd?=
 =?us-ascii?Q?uGQiULRlZd5sStOmR0b8E1FmhjBuxQoT1ZLrjlRoKg1+aTPkmz1JWfNNee6K?=
 =?us-ascii?Q?C29M/v6V1Bh4/RlwQyVr8vxkTqSmz39Vs0ofSmA8d+Ch738EAE1sXqIWIzc/?=
 =?us-ascii?Q?BdZs6VvcpgipZlnSIWODGd2k2wvLHPEFubEB6oX66EsLt/8DHM0QOl4c9Fva?=
 =?us-ascii?Q?W6EhqgNKdDo7QF0iK6uwrH1ITTqe4eXaLJkOZPoV3n1OtxdxI04qsHuuWt/p?=
 =?us-ascii?Q?dbf7dhDSIYoswPcsBUoOBbtT8WSk+eLwL9nD57+8obZofh2UUK+Wrpdit3cb?=
 =?us-ascii?Q?01dvIs3lzBewBanTj90DBedPNbzWC5qVqSkEAvJ7tCYJoO9ME/74kQ6pRnb9?=
 =?us-ascii?Q?PevAM9ljYdaOAbHbWz/sUi3jOXnlUxRUpuqsdYNzCEQMFJvmYRYxd1FA2BbW?=
 =?us-ascii?Q?Kwc5pYkMfSxcaffy5IXxqQ8/APCEJrCjT0C1i69aYq435sMIbwtLoPXjyb/p?=
 =?us-ascii?Q?m00IEoIT+e6CkYtCYxoLLDddQJcr1/TD3DCnquFcpGgwbq80lcXQtTguliJR?=
 =?us-ascii?Q?VaPJmy44C4Vxht3hIA9xO2GbSb8pDF0titD84x25kihDbFUmcZkLNQ+zBCbz?=
 =?us-ascii?Q?AV+XOVaYM24+R4nHMvXtjRhiiHBEYp0Mu7MlYf6Nwh2ppH5O+yJhfI9TuAc6?=
 =?us-ascii?Q?PZFx95y5oKfbQC9wVDSu6bpLEdqGMax3B7aWbU3QNJbgB+qZSgESEx4/lplf?=
 =?us-ascii?Q?1ZKjlGa03c4wYW30xd65Royr1ckQABBT6HckgfCjTZLQjPw9KP5W2MX4xHE0?=
 =?us-ascii?Q?HifSrC775bVsvpTOojnKEATI?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 684cbcc6-3ba2-499a-5708-08dc4a5b9175
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 10:33:52.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB5238

The keyboard backlight control is not enabled by default on all devices
with a Chromium EC, e.g. my Framework 13. This patch series enables it
if the feature is present in the EC, instead of relying on
`of_match_table`s or whatever.

These patches are tested and working on my Framework 13, and KDE's
keyboard brightness slider even works. It's also gone though a couple of
reboot & sleep cycles without issue.

Also this is my first time submitting a patch to the kernel, and I'm keen
to do more, so please let me know if I've done anything wrong.

Thanks,
Steve

Stephen Horvath (2):
  platform/chrome: cros_kbd_led_backlight: Automatically enable keyboard
    backlight control if feature present in EC
  platform/chrome: cros_kbd_led_backlight: Remove obsolete commands
    (EC_CMD_PWM_*_KEYBOARD_BACKLIGHT)

 drivers/mfd/cros_ec_dev.c                     |  9 +++
 .../platform/chrome/cros_kbd_led_backlight.c  | 62 ++++++++++---------
 2 files changed, 43 insertions(+), 28 deletions(-)

-- 
2.43.0


