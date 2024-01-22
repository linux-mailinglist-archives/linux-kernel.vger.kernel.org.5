Return-Path: <linux-kernel+bounces-34213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4048375A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95163B22F77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C265F482EF;
	Mon, 22 Jan 2024 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cugfcyuo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AF482D1;
	Mon, 22 Jan 2024 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960517; cv=none; b=pX38a7Ch3EyK+e1Hmz+5Y0r3p3bjGvsNntAAgKJ7lxArZXqo2SWMicgzt9wpGrlWvwmlRhHPPliryZ6WIMtg7XQOr5nyJoQgTg5RMe+9n2HQg2GiXVAAfRKcjzkoB4t+ymkMuJSywE9yNKEy0Fw9b/zsywDiaJMIhpsJVmr/D70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960517; c=relaxed/simple;
	bh=KtugyW7AS+Y0kyu+UdduUUKiahxv+lkYKyHtEdZWmGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qnvWo6ktQeUMl+LwCqdP05hUE+xcKX4F3YArbMcdY5O28z3bXZsWolGTy0qVjmmSLwFdpb6ZDk6qdxyftzOrGrPL3yCXQXKfaYXt+i3P+WiM9sXRhtuNVM+EpwyHwoSDstW9UTqdBGzUY3eDLr26raA+JtWUXjvObUwcr+dNoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cugfcyuo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705960515; x=1737496515;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KtugyW7AS+Y0kyu+UdduUUKiahxv+lkYKyHtEdZWmGQ=;
  b=cugfcyuoRbRpwMfSNSYK79bhKoXHCZ1aFiPZkba1ObUi139L5MyuQSgJ
   wGO+tOlFCID3/ncAe6niWhzDXNhv+/R0GrpYjNphwAGsscVLU1CeLYAEC
   Bby6p64K1KS01PukoNp03bwkmKNy9nxX7TGR3XlXXTCFVcI55HVf+M6+2
   1KCr7xbJnBoscBsMXDD4SgZJp/7YUiRhiqGAeCO+6OAnJ/2ro2zX4Lj0k
   E5aDszmyJeMP2DzXN/FvbWmd2f2CDgTiWEkIhdIRD1DG7rgjeNrOcgUSq
   3cKDmTDyynS7QAxN6GGiXp8Zj2tpLXqxKKDnjzRXGASW9IqXYyndTg4zN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="14853463"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="14853463"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 13:55:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="904997364"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="904997364"
Received: from jacobrit-mobl1.amr.corp.intel.com ([10.213.179.193])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 13:55:13 -0800
Message-ID: <622f9ba5db1e4f4e72d14bf8d918d27033f88167.camel@linux.intel.com>
Subject: Re: [PATCH] tracing: Ensure visibility when inserting an element
 into tracing_map
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>, rostedt@goodmis.org,
 mhiramat@kernel.org,  mathieu.desnoyers@efficios.com
Cc: vedang.patel@intel.com, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 22 Jan 2024 15:55:12 -0600
In-Reply-To: <20240122150928.27725-1-petr.pavlu@suse.com>
References: <20240122150928.27725-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Petr,

On Mon, 2024-01-22 at 16:09 +0100, Petr Pavlu wrote:
> Running the following two commands in parallel on a multi-processor
> AArch64 machine can sporadically produce an unexpected warning about
> duplicate histogram entries:
>=20
> =C2=A0$ while true; do
> =C2=A0=C2=A0=C2=A0=C2=A0 echo hist:key=3Did.syscall:val=3Dhitcount > \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/kernel/debug/tracing/events/raw=
_syscalls/sys_enter/trigger
> =C2=A0=C2=A0=C2=A0=C2=A0 cat /sys/kernel/debug/tracing/events/raw_syscall=
s/sys_enter/hist
> =C2=A0=C2=A0=C2=A0=C2=A0 sleep 0.001
> =C2=A0=C2=A0 done
> =C2=A0$ stress-ng --sysbadaddr $(nproc)
>=20
> The warning looks as follows:
>=20
> [ 2911.172474] ------------[ cut here ]------------
> [ 2911.173111] Duplicates detected: 1
> [ 2911.173574] WARNING: CPU: 2 PID: 12247 at kernel/trace/tracing_map.c:9=
83 tracing_map_sort_entries+0x3e0/0x408
> [ 2911.174702] Modules linked in: iscsi_ibft(E) iscsi_boot_sysfs(E) rfkil=
l(E) af_packet(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) ena(E) tiny_=
power_button(E) qemu_fw_cfg(E) button(E) fuse(E) efi_pstore(E) ip_tables(E)=
 x_tables(E) xfs(E) libcrc32c(E) aes_ce_blk(E) aes_ce_cipher(E) crct10dif_c=
e(E) polyval_ce(E) polyval_generic(E) ghash_ce(E) gf128mul(E) sm4_ce_gcm(E)=
 sm4_ce_ccm(E) sm4_ce(E) sm4_ce_cipher(E) sm4(E) sm3_ce(E) sm3(E) sha3_ce(E=
) sha512_ce(E) sha512_arm64(E) sha2_ce(E) sha256_arm64(E) nvme(E) sha1_ce(E=
) nvme_core(E) nvme_auth(E) t10_pi(E) sg(E) scsi_mod(E) scsi_common(E) efiv=
arfs(E)
> [ 2911.174738] Unloaded tainted modules: cppc_cpufreq(E):1
> [ 2911.180985] CPU: 2 PID: 12247 Comm: cat Kdump: loaded Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.7.0-default #2 1b58bbb22c97e4399dc09f92d309344f69c44a0=
1
> [ 2911.182398] Hardware name: Amazon EC2 c7g.8xlarge/, BIOS 1.0 11/1/2018
> [ 2911.183208] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
> [ 2911.184038] pc : tracing_map_sort_entries+0x3e0/0x408
> [ 2911.184667] lr : tracing_map_sort_entries+0x3e0/0x408
> [ 2911.185310] sp : ffff8000a1513900
> [ 2911.185750] x29: ffff8000a1513900 x28: ffff0003f272fe80 x27: 000000000=
0000001
> [ 2911.186600] x26: ffff0003f272fe80 x25: 0000000000000030 x24: 000000000=
0000008
> [ 2911.187458] x23: ffff0003c5788000 x22: ffff0003c16710c8 x21: ffff80008=
017f180
> [ 2911.188310] x20: ffff80008017f000 x19: ffff80008017f180 x18: fffffffff=
fffffff
> [ 2911.189160] x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000a=
15134b8
> [ 2911.190015] x14: 0000000000000000 x13: 205d373432323154 x12: 5b5d31313=
1333731
> [ 2911.190844] x11: 00000000fffeffff x10: 00000000fffeffff x9 : ffffd1b78=
274a13c
> [ 2911.191716] x8 : 000000000017ffe8 x7 : c0000000fffeffff x6 : 000000000=
057ffa8
> [ 2911.192554] x5 : ffff0012f6c24ec0 x4 : 0000000000000000 x3 : ffff2e5b7=
2b5d000
> [ 2911.193404] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0003f=
f254480
> [ 2911.194259] Call trace:
> [ 2911.194626]=C2=A0 tracing_map_sort_entries+0x3e0/0x408
> [ 2911.195220]=C2=A0 hist_show+0x124/0x800
> [ 2911.195692]=C2=A0 seq_read_iter+0x1d4/0x4e8
> [ 2911.196193]=C2=A0 seq_read+0xe8/0x138
> [ 2911.196638]=C2=A0 vfs_read+0xc8/0x300
> [ 2911.197078]=C2=A0 ksys_read+0x70/0x108
> [ 2911.197534]=C2=A0 __arm64_sys_read+0x24/0x38
> [ 2911.198046]=C2=A0 invoke_syscall+0x78/0x108
> [ 2911.198553]=C2=A0 el0_svc_common.constprop.0+0xd0/0xf8
> [ 2911.199157]=C2=A0 do_el0_svc+0x28/0x40
> [ 2911.199613]=C2=A0 el0_svc+0x40/0x178
> [ 2911.200048]=C2=A0 el0t_64_sync_handler+0x13c/0x158
> [ 2911.200621]=C2=A0 el0t_64_sync+0x1a8/0x1b0
> [ 2911.201115] ---[ end trace 0000000000000000 ]---
>=20
> The problem appears to be caused by CPU reordering of writes issued from
> __tracing_map_insert().
>=20
> The check for the presence of an element with a given key in this
> function is:
>=20
> =C2=A0val =3D READ_ONCE(entry->val);
> =C2=A0if (val && keys_match(key, val->key, map->key_size)) ...
>=20
> The write of a new entry is:
>=20
> =C2=A0elt =3D get_free_elt(map);
> =C2=A0memcpy(elt->key, key, map->key_size);
> =C2=A0entry->val =3D elt;
>=20
> The "memcpy(elt->key, key, map->key_size);" and "entry->val =3D elt;"
> stores may become visible in the reversed order on another CPU. This
> second CPU might then incorrectly determine that a new key doesn't match
> an already present val->key and subsequently insert a new element,
> resulting in a duplicate.
>=20
> Fix the problem by adding a write barrier between
> "memcpy(elt->key, key, map->key_size);" and "entry->val =3D elt;", and fo=
r
> good measure, also use WRITE_ONCE(entry->val, elt) for publishing the
> element. The sequence pairs with the mentioned "READ_ONCE(entry->val);"
> and the "val->key" check which has an address dependency.
>=20
> The barrier is placed on a path executed when adding an element for
> a new key. Subsequent updates targeting the same key remain unaffected.
>=20
> From the user's perspective, the issue was introduced by commit
> c193707dde77 ("tracing: Remove code which merges duplicates"), which
> followed commit cbf4100efb8f ("tracing: Add support to detect and avoid
> duplicates"). The previous code operated differently; it inherently
> expected potential races which result in duplicates but merged them
> later when they occurred.
>=20
> Fixes: c193707dde77 ("tracing: Remove code which merges duplicates")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
> =C2=A0kernel/trace/tracing_map.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> index c774e560f2f9..a4dcf0f24352 100644
> --- a/kernel/trace/tracing_map.c
> +++ b/kernel/trace/tracing_map.c
> @@ -574,7 +574,12 @@ __tracing_map_insert(struct tracing_map *map, void *=
key, bool lookup_only)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy(elt->key, key, map->key=
_size);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0entry->val =3D elt;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure the initialization is visi=
ble and
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * publish the elt.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0smp_wmb();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WRITE_ONCE(entry->val, elt);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0atomic64_inc(&map->hits);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return entry->val;
>=20
> base-commit: 9d1694dc91ce7b80bc96d6d8eaf1a1eca668d847

Makes sense, thanks for fixing this!

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Tom




