Return-Path: <linux-kernel+bounces-139328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA58A0177
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E833B26F33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2078181D00;
	Wed, 10 Apr 2024 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=northeastern.edu header.i=@northeastern.edu header.b="iPHxFepc"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2096.outbound.protection.outlook.com [40.107.237.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA341180A70;
	Wed, 10 Apr 2024 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782201; cv=fail; b=K24IFHE4I4o0f8kMrs70qbRCwtq9EcuTwnWhWws83bJtacUy3wAm32vLqT5iT3GnAvYK5u8BmHmwGCItE/5QrCZ/YL/KOJIL5YKdaOtEyX8kal4GkFLCcd8OTA0k9YPRpXz66UGOhLO0qkZ+VzIA5feiVdXHMtPZ2tBnY6HpG9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782201; c=relaxed/simple;
	bh=ooHGxu6hAoVLsOf58WFS6OZirTVWhamiw/GHVThM6P8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LijaPoLgx+DUiAQ4Infm6CiuBIiebkNc/HZWQ0IjG1kNwcNfBbCQ/6ScltZjSC9QkPz21NFSNWxDFGcnZl31fPcl9PteVFPNiV37aR1qsKEHem/8ef9C9pjo1rB8Eclhp8Iga6EJrwmD7wrcqnnzZw+NqntkOiH8Vg9Hi355vBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=northeastern.edu; spf=pass smtp.mailfrom=northeastern.edu; dkim=pass (2048-bit key) header.d=northeastern.edu header.i=@northeastern.edu header.b=iPHxFepc; arc=fail smtp.client-ip=40.107.237.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=northeastern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=northeastern.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu1vMUwEleDtLV4kAeWVY2s+UwgbEr64xWPmJna4sR20KM2YchCWVZdg7xSIeMu3VFb6486rjpd03fHzEVRKY3wriZGNIhAMLFCXwLbd4fERdaokENeC0uEijN9BQ5SpfzZnLczpqTaW5iE0s7SBHRh3PLTN2IaBeXwzCweSP8rJkE7GffMOFbBgiqHBOqmkGBA/wJKu2MLWI6cT/eKqVSUJLRufBqDPuG6+6Sjcl8jljakfj6UUDMOCR30zroPrOP04gZ9eqZkTzcesoVRKERvDRFwc/zGj6lTbvi2620pHSCt6FNes+dmNv+DsvjBf+lUqUw+voDyE38NY48zF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooHGxu6hAoVLsOf58WFS6OZirTVWhamiw/GHVThM6P8=;
 b=mTzjw0hbNaihPI06Qs2HXLY5zWCyQ6xq5qNxsfFlhCCilO9kvfN/qhAbstaysOhB6XeqVRXIEYD3x+3RAj+THCB0yV2gTVNCMu+fLHQryMqGw9uWWkPaBBCsHM6xrZhP6rf3EQ5/XarASjWvyhG6FOUOb92//KcNK+VPb5qcpVEK1B4DfMO5qPm/zpM7Fc0BbdARiKPwpBomCWjUZJoPo/kcB9MN/+Cgd+22Za0NYsBeKwsospKW7nAaJiK1vq7jsafrRwLdYuztNhzUZ4mP74UajN8l0A6shUxtrNsv/WA396i//FqbZhXQUUVppu4VvjGBQRQIq1fH4x7Atk9gMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=northeastern.edu; dmarc=pass action=none
 header.from=northeastern.edu; dkim=pass header.d=northeastern.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=northeastern.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooHGxu6hAoVLsOf58WFS6OZirTVWhamiw/GHVThM6P8=;
 b=iPHxFepcZMfCt9oacrjn5IAaYQunvmC7+Tvt/nHJKauLcIsqYZxEx1dulwG2oE9AXhKN7XvcX7MfJs8Zi2tSY5YMknoeuqsWtrK5QxIACUFkKNziOegRM6Upxm+4pqHsV0oa3/Ii1OO0iRHzJRltqc9m8kl+JTEEa6/hdUFIoo0mSLqKXDHRh/INJ0Sfgi3f9wHUqpxKjUSSVlVVdbV3kY0aR13CePPavc1BUTRMrHZ7Kj+c1Tmicm5Y75IsiFF+sgWfyU/HDvKEkR128KB+i0/+2nFghE0G1lLpan1CsMRB7/8QBsn1FokccKqLbyou6b9fME9vRMQXGBWD5wzcZg==
Received: from PH0PR06MB7560.namprd06.prod.outlook.com (2603:10b6:510:50::12)
 by BLAPR06MB6835.namprd06.prod.outlook.com (2603:10b6:208:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 20:49:57 +0000
Received: from PH0PR06MB7560.namprd06.prod.outlook.com
 ([fe80::592e:30c3:df5c:e283]) by PH0PR06MB7560.namprd06.prod.outlook.com
 ([fe80::592e:30c3:df5c:e283%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 20:49:57 +0000
From: Cem Topcuoglu <topcuoglu.c@northeastern.edu>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Parthik Bhardwaj <bhardwaj.p@northeastern.edu>, Changming Liu
	<liu.changm@northeastern.edu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: KASAN: slab-out-of-bounds Write in ops_init
Thread-Topic: KASAN: slab-out-of-bounds Write in ops_init
Thread-Index: AQHai4dnYs4chMLq7Eew5HPFNvVa1g==
Date: Wed, 10 Apr 2024 20:49:57 +0000
Message-ID:
 <PH0PR06MB75601C41918660D3D1C2574894062@PH0PR06MB7560.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR06MB7560:EE_|BLAPR06MB6835:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2feHmdBV4h9C9kqXAGuCIAk7Rds8WSCcqeQBwVO62TO/NdrqXP3/s5Ni6CNuOKFGq+dIeZPeMkthB+x/lbMP9n05gVragn/X8ZNaNkXB15O2b2hnlC+GtWEuhZtlVxWdsacgrXfWWc4eO6ki3XORNUQQmmdnepMEr782SlM45Y/TxuwEe/IQK/9eSCnZa4kInnLYxtq0pWuPKbzhHqYKryL14nQ4Rpxtt1WeyFKbHt0iwz7GkjY2j/yqVLpKYC1UELdMPE01exQ625IzFL33w9yTz/5QZ7VfaOsLKPApqviMeXxl6Nm7iJuPvcgLc/vLrnmvqcqSITGF/H/+bRa1QCwBrLuz2xd2jjv3TtAO+wokBxI6Il2h7zF5WAimffxQSi8305njWiGxLnWVX6742lqkp+GbOidZPWjfNeSo36vytPYhsWK3n0hYt8q07sFFHTY3b+yCHMd4quGkVQE5nViwRYA72pcmR3CK/6ZrjAF3h49fx3XndCSMWHJQxFywTzLrne/r/blnbApcx8ByI3j/5YBL4a4mWmB01v07sZCbvYWwkRJu1CwnX4ZV/1fgEgGQs/iNfcllgE+pnBIlzEXJmLw9erjT1jJya0pOQoDamekkklfAxKRojkmSJmXixMVs+YGN1t4yhG69m+p1i6USn8NwSYTqr8+T416BZmA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR06MB7560.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?d8zfK0lt4Dpb5xfYB2bpkC1HGw4N77yDZiYa1e2lJmFney8cog1Jb7u6?=
 =?Windows-1252?Q?qpU8tfWtoS5N1aWOYQqjujiA+DTe41266LiApd9sEEpGA4sz+p7oruvt?=
 =?Windows-1252?Q?7G8h+pk6mA3ByTDrA8Nc4i92qX0H8JteW1tHThK7v7RFTWmzfTf30U6w?=
 =?Windows-1252?Q?/8mcb9ZOtx2AYUwBDUVdMbpCInMk2FxwHoggQxwVZHobciEAG7ws48ZR?=
 =?Windows-1252?Q?yiTNXdNIT1NBIQxkKrhiKwmJYIf1sLO6Fr9ZXxMqk2zAoxMm7istoCAM?=
 =?Windows-1252?Q?TZHQuf6hUieqHFpDhM2dy4+xaOC0CbopwQYBWQyN4f1g5sDeAT8XIPYC?=
 =?Windows-1252?Q?7lAtHBYab6P2XaitTma0ikh51g23Avu6wSkQqQwW5gD/HsgTfohrKf2e?=
 =?Windows-1252?Q?fMzzBe4i4bs/PLeu5qFrzqAtXxcpkrnxBBocYwEoC0TAjtI0mAwsnDPQ?=
 =?Windows-1252?Q?r+yEnGM2jBO3k0QHgZ/O/JMnS5m1DAocAFWwtFzE4MMmbxs5F5RBIK5Z?=
 =?Windows-1252?Q?WLb9RrtnTu/EuAF3einZYyO+SDaU+N/5iAJbwVcbh2sGBpSRADL3bi/0?=
 =?Windows-1252?Q?Wtjb7i/FslLxrE7MCy++3a3ZzD1ljRHzIplIlaIBo4/7iOJz4KC38Jpy?=
 =?Windows-1252?Q?VpCdyWmny7wqXSb0ohzFcXg5OgkKh3CXQzN6p/bQWDzt8JJlNEBVJZkA?=
 =?Windows-1252?Q?FISkf2opUBMH7APsSavfR/Id6wjknlCugvkhy/3vSrC7mXtPZivudD97?=
 =?Windows-1252?Q?H/xfYGXRK5tTSbmV+b7bBg4Y7D1c5Lm/PweOC8rr19kD6z1BjwXcHrVJ?=
 =?Windows-1252?Q?zn6qr8RH65o1uz8n1OCza9UeAmtFnMf9zvCwrrt/LJOorlThAKf4ijx4?=
 =?Windows-1252?Q?9gYxrk3Y28hGFYy4By4LdDi1mpR36Xzr6ISQI096Ag97zBY04ZvMzRly?=
 =?Windows-1252?Q?0DRH/vDQwljOjxhxRG7ADfvpoSV1m4mczfbnezN1pajK/eACo1Fnm9++?=
 =?Windows-1252?Q?A0afuKOBx92snOAO9V4CFJCPDs9OFRT4IfSncmuvQhbWGNQgWLbGw/gS?=
 =?Windows-1252?Q?U8l90NYRVqqCmQ8SYl7TQzwjCqybpUN7mDMJjYlhynbgKtwNNEkY5cKd?=
 =?Windows-1252?Q?tnXzs6QE1UHwOHL4qwYRLWizHBRI0ZJtH2LMkLfuJ3CbsdXinsNQR7+b?=
 =?Windows-1252?Q?/LCEh8s47591COvRc88OU21XSmkv9nPqbOK91kVbqNg+EmbnPofEXEIW?=
 =?Windows-1252?Q?UDwEO/COLZpbV7mIDU9dXrug1AlCBcrxQcWsneKPlY+UXoW4J14pdFmu?=
 =?Windows-1252?Q?SBRM16vK0gb0cn9mSknbmF7dOiiViKAW1EfW74Aq0moKMWpLbKCiA3zg?=
 =?Windows-1252?Q?YCXtKNpdWE97ikuod4Im0oxAuECeVpho+0V+yPYKCqeSAkp2fM4O9Xon?=
 =?Windows-1252?Q?5BehQqnyPe5m3DPH2iel8Cv6Znk+ug4tA5P4RU2ID+KzX/LGWEJXEOPk?=
 =?Windows-1252?Q?0f9fINB6gmB8M5UtmoSnXlWgetJduuaS1GToXNMYEWQUM2KncaGjoq0X?=
 =?Windows-1252?Q?mqvAjTtPO7M2CaLVNs5gp5QxyzeD45sBDMCD8yTPPnQr7kX9CE15mGoG?=
 =?Windows-1252?Q?/UlpIt2nuzVonyrfT0a2KzgOGoiqOVVQ3FZueRTBib560k4WK9oTIyzb?=
 =?Windows-1252?Q?MpyD0N99rul83SiR4C9VCSlZ8Mdj7vlD?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: northeastern.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR06MB7560.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6ace89-4e24-4ca6-1f9e-08dc599fc81a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 20:49:57.1435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a8eec281-aaa3-4dae-ac9b-9a398b9215e7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oq8FVbYs8+CgPYYEZUDVclYyoDhJ8dFbEravHJWAEXKghvqXTWw66DOtQM53DEXSjtpxauPrvj4txKnWxd62qBOK/nd5X2za3uobTchxzYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR06MB6835

Hi,=0A=
=0A=
We encountered a bug labelled =93KASAN: slab-out-of-bounds Write in ops_ini=
t=94 while fuzzing kernel version 5.15.124 with Syzkaller (lines exist in 5=
15.154 as well).=0A=
=A0=0A=
In the net_namespace.c file, we have an if condition at line 89. Subsequent=
ly, Syzkaller encounters the bug at line 90.=0A=
=A0=0A=
89=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (old_ng->s.len > id) {=0A=
90=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 old_ng->ptr[id] =3D =
data;=0A=
91=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
92=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
Upon inspecting the net_generic struct, we noticed that this struct uses un=
ion which puts the array and the header (including the array length informa=
tion) together.=0A=
We suspect that with this union, modifying the ng->ptr[0] is essentially mo=
difying ng->s.len, which might fail the check in 89. This might be the caus=
e for Syzkaller detecting this slab-out-of-bound.=A0=0A=
Since we are CS PhD students and Linux hobbyists, we do not have a full und=
erstanding of what could lead to this. We would really appreciate if you gu=
ys can share some insights into this matter : )=0A=
=A0=0A=
We attached the syzkaller=92s bug report below.=0A=
=A0=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
BUG: KASAN: slab-out-of-bounds in net_assign_generic=0A=
usr/src/kernel/net/core/net_namespace.c:90 [inline]=0A=
BUG: KASAN: slab-out-of-bounds in ops_init+0x44b/0x4d0=0A=
usr/src/kernel/net/core/net_namespace.c:129=0A=
Write of size 8 at addr ffff888043c62ae8 by task (coredump)/5424=0A=
CPU: 1 PID: 5424 Comm: (coredump) Not tainted 5.15.124-yocto-standard #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1=
 04/01/2014=0A=
Call Trace:=0A=
<TASK>=0A=
__dump_stack usr/src/kernel/lib/dump_stack.c:88 [inline]=0A=
dump_stack_lvl+0x51/0x70 usr/src/kernel/lib/dump_stack.c:106=0A=
print_address_description.constprop.0+0x24/0x140 usr/src/kernel/mm/kasan/re=
port.c:248=0A=
__kasan_report usr/src/kernel/mm/kasan/report.c:434 [inline]=0A=
kasan_report.cold+0x7d/0x117 usr/src/kernel/mm/kasan/report.c:451=0A=
__asan_report_store8_noabort+0x17/0x20 usr/src/kernel/mm/kasan/report_gener=
ic.c:314=0A=
net_assign_generic usr/src/kernel/net/core/net_namespace.c:90 [inline]=0A=
ops_init+0x44b/0x4d0 usr/src/kernel/net/core/net_namespace.c:129=0A=
setup_net+0x40a/0x970 usr/src/kernel/net/core/net_namespace.c:329=0A=
copy_net_ns+0x2ac/0x680 usr/src/kernel/net/core/net_namespace.c:473=0A=
create_new_namespaces+0x390/0xa50 usr/src/kernel/kernel/nsproxy.c:110=0A=
unshare_nsproxy_namespaces+0xb0/0x1d0 usr/src/kernel/kernel/nsproxy.c:226=
=0A=
ksys_unshare+0x30c/0x850 usr/src/kernel/kernel/fork.c:3094=0A=
__do_sys_unshare usr/src/kernel/kernel/fork.c:3168 [inline]=0A=
__se_sys_unshare usr/src/kernel/kernel/fork.c:3166 [inline]=0A=
__x64_sys_unshare+0x36/0x50 usr/src/kernel/kernel/fork.c:3166=0A=
do_syscall_x64 usr/src/kernel/arch/x86/entry/common.c:50 [inline]=0A=
do_syscall_64+0x40/0x90 usr/src/kernel/arch/x86/entry/common.c:80=0A=
entry_SYSCALL_64_after_hwframe+0x61/0xcb=0A=
RIP: 0033:0x7fbafce1b39b=0A=
Code: 73 01 c3 48 8b 0d 85 2a 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f =
1f 84 00 00 00 00=0A=
00 90 f3 0f 1e fa b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0=
d 55 2a 0e 00 f7=0A=
d8 64 89 01 48=0A=
RSP: 002b:00007ffddc8dfda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110=0A=
RAX: ffffffffffffffda RBX: 0000557e645dd018 RCX: 00007fbafce1b39b=0A=
RDX: 0000000000000000 RSI: 00007ffddc8dfd10 RDI: 0000000040000000=0A=
RBP: 00007ffddc8dfde0 R08: 0000000000000000 R09: 00007ffd00000067=0A=
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000fffffff5=0A=
R13: 00007fbafd26ba60 R14: 0000000040000000 R15: 0000000000000000=0A=
</TASK>=0A=
Allocated by task 5424:=0A=
kasan_save_stack+0x26/0x60 usr/src/kernel/mm/kasan/common.c:38=0A=
kasan_set_track usr/src/kernel/mm/kasan/common.c:46 [inline]=0A=
set_alloc_info usr/src/kernel/mm/kasan/common.c:434 [inline]=0A=
____kasan_kmalloc usr/src/kernel/mm/kasan/common.c:513 [inline]=0A=
____kasan_kmalloc usr/src/kernel/mm/kasan/common.c:472 [inline]=0A=
__kasan_kmalloc+0xae/0xe0 usr/src/kernel/mm/kasan/common.c:522=0A=
kasan_kmalloc usr/src/kernel/include/linux/kasan.h:264 [inline]=0A=
__kmalloc+0x308/0x560 usr/src/kernel/mm/slub.c:4407=0A=
kmalloc usr/src/kernel/include/linux/slab.h:596 [inline]=0A=
kzalloc usr/src/kernel/include/linux/slab.h:721 [inline]=0A=
net_alloc_generic+0x28/0x80 usr/src/kernel/net/core/net_namespace.c:74=0A=
net_alloc usr/src/kernel/net/core/net_namespace.c:401 [inline]=0A=
copy_net_ns+0xc3/0x680 usr/src/kernel/net/core/net_namespace.c:460=0A=
create_new_namespaces+0x390/0xa50 usr/src/kernel/kernel/nsproxy.c:110=0A=
unshare_nsproxy_namespaces+0xb0/0x1d0 usr/src/kernel/kernel/nsproxy.c:226=
=0A=
ksys_unshare+0x30c/0x850 usr/src/kernel/kernel/fork.c:3094=0A=
__do_sys_unshare usr/src/kernel/kernel/fork.c:3168 [inline]=0A=
__se_sys_unshare usr/src/kernel/kernel/fork.c:3166 [inline]=0A=
__x64_sys_unshare+0x36/0x50 usr/src/kernel/kernel/fork.c:3166=0A=
do_syscall_x64 usr/src/kernel/arch/x86/entry/common.c:50 [inline]=0A=
do_syscall_64+0x40/0x90 usr/src/kernel/arch/x86/entry/common.c:80=0A=
entry_SYSCALL_64_after_hwframe+0x61/0xcb=0A=
The buggy address belongs to the object at ffff888043c62a00=0A=
which belongs to the cache kmalloc-256 of size 256=0A=
The buggy address is located 232 bytes inside of=0A=
256-byte region [ffff888043c62a00, ffff888043c62b00)=0A=
The buggy address belongs to the page:=0A=
page:000000008dd0a6b6 refcount:1 mapcount:0 mapping:0000000000000000 index:=
0x0 pfn:0x43c62=0A=
head:000000008dd0a6b6 order:1 compound_mapcount:0=0A=
flags: 0x4000000000010200(slab|head|zone=3D1)=0A=
raw: 4000000000010200 ffffea0001108f00 0000000700000007 ffff888001041b40=0A=
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000=0A=
page dumped because: kasan: bad access detected=0A=
Memory state around the buggy address:=0A=
ffff888043c62980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
ffff888043c62a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
>ffff888043c62a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc=0A=
^=0A=
ffff888043c62b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
ffff888043c62b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
kmemleak: 2 new suspected memory leaks (see /sys/kernel/debug/kmemleak)=0A=
=A0=0A=
Best=0A=
=A0=

