Return-Path: <linux-kernel+bounces-167837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25908BB011
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84449284494
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC515534D;
	Fri,  3 May 2024 15:36:23 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB482155381;
	Fri,  3 May 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750583; cv=none; b=RUEqI4EUt527ZC/wX8BTJ2ztuIxEFd3apXi/ovlZm0GoTFUJvK/MY4GCr1zZ9Tsmr/Pi5UjjIjfOaAxrmGWq1OvEwBUt2GoVorYEN6exYc+ODIqYiEzqYC4U84w9oz9nk9umqfBN/eq4oTg8/6zfpkZ5KCscr20HoONEN57M/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750583; c=relaxed/simple;
	bh=EEzyDCZSh6ttVm4linWJjoeObBMB6/2+NDDUDhynMBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX2ySl2J2ZQeCay36CWYWtXSo8uFqNhAvZ21cuLbwzt1v0rgMTlqNoUudlJbUVqR5Lp2WYzByCT3zzTOF3p4vpZ+q50BROo7vTIwQIBfqNfL64NCEORv0VdF2tho+FcHcYUNblz0VYm9K6C6z9IfAM9+JIGJS/H2gFUDSSSuzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1s2uxF-000000000Qp-259l;
	Fri, 03 May 2024 15:36:09 +0000
Date: Fri, 3 May 2024 16:36:06 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: INAGAKI Hiroshi <musashino.open@gmail.com>
Cc: axboe@kernel.dk, yang.yang29@zte.com, justinstitt@google.com,
	xu.panda@zte.com.cn, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Naohiro Aota <naota@elisp.net>
Subject: Re: [PATCH] block: fix and simplify blkdevparts= cmdline parsing
Message-ID: <ZjUEZtsJTaUt-5Yj@makrotopia.org>
References: <20240421074005.565-1-musashino.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421074005.565-1-musashino.open@gmail.com>

On Sun, Apr 21, 2024 at 04:39:52PM +0900, INAGAKI Hiroshi wrote:
> Fix the cmdline parsing of the "blkdevparts=" parameter using strsep(),
> which makes the code simpler.
> 
> Before commit 146afeb235cc ("block: use strscpy() to instead of
> strncpy()"), we used a strncpy() to copy a block device name and partition
> names. The commit simply replaced a strncpy() and NULL termination with
> a strscpy(). It did not update calculations of length passed to strscpy().
> While the length passed to strncpy() is just a length of valid characters
> without NULL termination ('\0'), strscpy() takes it as a length of the
> destination buffer, including a NULL termination.
> 
> Since the source buffer is not necessarily NULL terminated, the current
> code copies "length - 1" characters and puts a NULL character in the
> destination buffer. It replaces the last character with NULL and breaks
> the parsing.
> 
> As an example, that buffer will be passed to parse_parts() and breaks
> parsing sub-partitions due to the missing ')' at the end, like the
> following.
> 
> example (Check Point V-80 & OpenWrt):
> 
> - Linux Kernel 6.6
> 
>   [    0.000000] Kernel command line: console=ttyS0,115200 earlycon=uart8250,mmio32,0xf0512000 crashkernel=30M mvpp2x.queue_mode=1 blkdevparts=mmcblk1:48M@10M(kernel-1),1M(dtb-1),720M(rootfs-1),48M(kernel-2),1M(dtb-2),720M(rootfs-2),300M(default_sw),650M(logs),1M(preset_cfg),1M(adsl),-(storage) maxcpus=4
>   ...
>   [    0.884016] mmc1: new HS200 MMC card at address 0001
>   [    0.889951] mmcblk1: mmc1:0001 004GA0 3.69 GiB
>   [    0.895043] cmdline partition format is invalid.
>   [    0.895704]  mmcblk1: p1
>   [    0.903447] mmcblk1boot0: mmc1:0001 004GA0 2.00 MiB
>   [    0.908667] mmcblk1boot1: mmc1:0001 004GA0 2.00 MiB
>   [    0.913765] mmcblk1rpmb: mmc1:0001 004GA0 512 KiB, chardev (248:0)
> 
>   1. "48M@10M(kernel-1),..." is passed to strscpy() with length=17
>      from parse_parts()
>   2. strscpy() returns -E2BIG and the destination buffer has
>      "48M@10M(kernel-1\0"
>   3. "48M@10M(kernel-1\0" is passed to parse_subpart()
>   4. parse_subpart() fails to find ')' when parsing a partition name,
>      and returns error
> 
> - Linux Kernel 6.1
> 
>   [    0.000000] Kernel command line: console=ttyS0,115200 earlycon=uart8250,mmio32,0xf0512000 crashkernel=30M mvpp2x.queue_mode=1 blkdevparts=mmcblk1:48M@10M(kernel-1),1M(dtb-1),720M(rootfs-1),48M(kernel-2),1M(dtb-2),720M(rootfs-2),300M(default_sw),650M(logs),1M(preset_cfg),1M(adsl),-(storage) maxcpus=4
>   ...
>   [    0.953142] mmc1: new HS200 MMC card at address 0001
>   [    0.959114] mmcblk1: mmc1:0001 004GA0 3.69 GiB
>   [    0.964259]  mmcblk1: p1(kernel-1) p2(dtb-1) p3(rootfs-1) p4(kernel-2) p5(dtb-2) 6(rootfs-2) p7(default_sw) p8(logs) p9(preset_cfg) p10(adsl) p11(storage)
>   [    0.979174] mmcblk1boot0: mmc1:0001 004GA0 2.00 MiB
>   [    0.984674] mmcblk1boot1: mmc1:0001 004GA0 2.00 MiB
>   [    0.989926] mmcblk1rpmb: mmc1:0001 004GA0 512 KiB, chardev (248:0
> 
> By the way, strscpy() takes a length of destination buffer and it is
> often confusing when copying characters with a specified length. Using
> strsep() helps to separate the string by the specified character. Then,
> we can use strscpy() naturally with the size of the destination buffer.
> 
> Separating the string on the fly is also useful to omit the redundant
> string copy, reducing memory usage and improve the code readability.
> 
> Fixes: 146afeb235cc ("block: use strscpy() to instead of strncpy()")
> Suggested-by: Naohiro Aota <naota@elisp.net>
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  block/partitions/cmdline.c | 49 ++++++++++----------------------------
>  1 file changed, 12 insertions(+), 37 deletions(-)
> 
> diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
> index c03bc105e575..152c85df92b2 100644
> --- a/block/partitions/cmdline.c
> +++ b/block/partitions/cmdline.c
> @@ -70,8 +70,8 @@ static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
>  	}
>  
>  	if (*partdef == '(') {
> -		int length;
> -		char *next = strchr(++partdef, ')');
> +		partdef++;
> +		char *next = strsep(&partdef, ")");
>  
>  		if (!next) {
>  			pr_warn("cmdline partition format is invalid.");
> @@ -79,11 +79,7 @@ static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
>  			goto fail;
>  		}
>  
> -		length = min_t(int, next - partdef,
> -			       sizeof(new_subpart->name) - 1);
> -		strscpy(new_subpart->name, partdef, length);
> -
> -		partdef = ++next;
> +		strscpy(new_subpart->name, next, sizeof(new_subpart->name));
>  	} else
>  		new_subpart->name[0] = '\0';
>  
> @@ -117,14 +113,12 @@ static void free_subpart(struct cmdline_parts *parts)
>  	}
>  }
>  
> -static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
> +static int parse_parts(struct cmdline_parts **parts, char *bdevdef)
>  {
>  	int ret = -EINVAL;
>  	char *next;
> -	int length;
>  	struct cmdline_subpart **next_subpart;
>  	struct cmdline_parts *newparts;
> -	char buf[BDEVNAME_SIZE + 32 + 4];
>  
>  	*parts = NULL;
>  
> @@ -132,28 +126,19 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
>  	if (!newparts)
>  		return -ENOMEM;
>  
> -	next = strchr(bdevdef, ':');
> +	next = strsep(&bdevdef, ":");
>  	if (!next) {
>  		pr_warn("cmdline partition has no block device.");
>  		goto fail;
>  	}
>  
> -	length = min_t(int, next - bdevdef, sizeof(newparts->name) - 1);
> -	strscpy(newparts->name, bdevdef, length);
> +	strscpy(newparts->name, next, sizeof(newparts->name));
>  	newparts->nr_subparts = 0;
>  
>  	next_subpart = &newparts->subpart;
>  
> -	while (next && *(++next)) {
> -		bdevdef = next;
> -		next = strchr(bdevdef, ',');
> -
> -		length = (!next) ? (sizeof(buf) - 1) :
> -			min_t(int, next - bdevdef, sizeof(buf) - 1);
> -
> -		strscpy(buf, bdevdef, length);
> -
> -		ret = parse_subpart(next_subpart, buf);
> +	while ((next = strsep(&bdevdef, ","))) {
> +		ret = parse_subpart(next_subpart, next);
>  		if (ret)
>  			goto fail;
>  
> @@ -199,24 +184,17 @@ static int cmdline_parts_parse(struct cmdline_parts **parts,
>  
>  	*parts = NULL;
>  
> -	next = pbuf = buf = kstrdup(cmdline, GFP_KERNEL);
> +	pbuf = buf = kstrdup(cmdline, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
>  
>  	next_parts = parts;
>  
> -	while (next && *pbuf) {
> -		next = strchr(pbuf, ';');
> -		if (next)
> -			*next = '\0';
> -
> -		ret = parse_parts(next_parts, pbuf);
> +	while ((next = strsep(&pbuf, ";"))) {
> +		ret = parse_parts(next_parts, next);
>  		if (ret)
>  			goto fail;
>  
> -		if (next)
> -			pbuf = ++next;
> -
>  		next_parts = &(*next_parts)->next_parts;
>  	}
>  
> @@ -250,7 +228,6 @@ static struct cmdline_parts *bdev_parts;
>  static int add_part(int slot, struct cmdline_subpart *subpart,
>  		struct parsed_partitions *state)
>  {
> -	int label_min;
>  	struct partition_meta_info *info;
>  	char tmp[sizeof(info->volname) + 4];
>  
> @@ -262,9 +239,7 @@ static int add_part(int slot, struct cmdline_subpart *subpart,
>  
>  	info = &state->parts[slot].info;
>  
> -	label_min = min_t(int, sizeof(info->volname) - 1,
> -			  sizeof(subpart->name));
> -	strscpy(info->volname, subpart->name, label_min);
> +	strscpy(info->volname, subpart->name, sizeof(info->volname));
>  
>  	snprintf(tmp, sizeof(tmp), "(%s)", info->volname);
>  	strlcat(state->pp_buf, tmp, PAGE_SIZE);
> -- 
> 2.25.1
> 
> 

