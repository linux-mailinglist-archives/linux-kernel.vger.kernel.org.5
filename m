Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33D4779AB2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjHKWZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjHKWZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:25:15 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD3AD7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:25:15 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 826F340E0194;
        Fri, 11 Aug 2023 22:25:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hl6GybLExMqd; Fri, 11 Aug 2023 22:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691792711; bh=6S7o2e/WFl1nojQzkl7Km50rbQB+UpZnOAavN8Uwa+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1lfkSZkQUQpw64DcsLu81pTPsGi3eOWGFZczAPuPN4n+LfcWrQgZCjWyIkzfpZ9n
         t9x0rtx+Pe3+5yiEcCT/UF0GnQcq7tZYbJccAfQ6CvZpcWHoDjJX2msZCp59kL1yGF
         xbYhhnJYIbyYoMSUNc7j5LCxfn9PvVS/+4R9uQWox8YllCt7jXdM7sL81vfpHJTRGL
         hPumjFhgLkc0e/8Dz4ctGVj/2LQbuL6gpqlAjMX4QZNBRfJiXnXLeQ2gdqeIiDESTp
         vizjMVDWsdFo4OzIQLYLQnn7opw7TlehEM8biofcn1syj7wKIer3nkSq4a0t6vaNmC
         7WkXUZOc/bR4hNRZ7vNd9uYHT86Cu4Pxx/amcqSzcP6wE5gwAW5hCyZ8kJDntaJUj+
         qGgQ3brh6CyptUdE1XRVqu16fvLRkTj0TfY8h4MnQwotJNohO/9MMPy1BOa16n/+PS
         /F6DZdDMUHBRS89oaYTKxzg6SgdG4fdRd+0lpd6IvMOFJsbFzscojciEXFeVDBozPN
         ByxLszChOXZTpNo1v3WtTqljrO1lqHiw5oHBwgM/V7W9myj/vo4d6ivfeUnTUmjjQO
         qPd7DsiKSbMZV+cFA0xlyJacspbtYX9++8LmOetkxy1+viBv7du91PXrOPiaK5QQee
         GUze0jXkud7ajuk7l3c51FlY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89F7B40E018F;
        Fri, 11 Aug 2023 22:25:06 +0000 (UTC)
Date:   Sat, 12 Aug 2023 00:25:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 08/30] x86/microcode/intel: Rip out mixed stepping
 support for Intel CPUs
Message-ID: <20230811222500.GOZNa1PIUVJeBDiBGI@fat_crate.local>
References: <20230810153317.850017756@linutronix.de>
 <20230810160805.418991257@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810160805.418991257@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 08:37:38PM +0200, Thomas Gleixner wrote:
> @@ -319,6 +264,7 @@ scan_microcode(void *data, size_t size,
>  {
>  	struct microcode_header_intel *mc_header;
>  	struct microcode_intel *patch = NULL;
> +	u32 cur_rev = uci->cpu_sig.rev;
>  	unsigned int mc_size;
>  
>  	while (size) {
> @@ -328,8 +274,7 @@ scan_microcode(void *data, size_t size,
>  		mc_header = (struct microcode_header_intel *)data;
>  
>  		mc_size = get_totalsize(mc_header);
> -		if (!mc_size ||
> -		    mc_size > size ||
> +		if (!mc_size || mc_size > size ||
>  		    intel_microcode_sanity_check(data, false, MC_HEADER_TYPE_MICROCODE) < 0)
>  			break;
>  
> @@ -341,31 +286,16 @@ scan_microcode(void *data, size_t size,
>  			continue;
>  		}
>  
> -		if (save) {
> -			save_microcode_patch(uci, data, mc_size);
> +		/* BSP scan: Check whether there is newer microcode */
> +		if (save && cur_rev >= mc_header->rev)
>  			goto next;
> -		}
> -
>  
> -		if (!patch) {
> -			if (!has_newer_microcode(data,
> -						 uci->cpu_sig.sig,
> -						 uci->cpu_sig.pf,
> -						 uci->cpu_sig.rev))
> -				goto next;
> -
> -		} else {
> -			struct microcode_header_intel *phdr = &patch->hdr;
> -
> -			if (!has_newer_microcode(data,
> -						 phdr->sig,
> -						 phdr->pf,
> -						 phdr->rev))
> -				goto next;
> -		}
> +		/* Save scan: Check whether there is newer or matching microcode */
> +		if (save && cur_rev != mc_header->rev)
> +			goto next;

I'm confused: when you look at those statements when this patch is
applied, they look like this:

                /* BSP scan: Check whether there is newer microcode */
                if (save && cur_rev >= mc_header->rev)
                        goto next;

                /* Save scan: Check whether there is newer or matching microcode */
                if (save && cur_rev != mc_header->rev)
                        goto next;

You'd only hit the second one if

		cur_rev < mc_header->rev

but then that implies

		cur_rev != mc_header->rev

too. I *think* you wanna have the first test be only ">" as you're
looking for newer microcode.

Besides, __load_ucode_intel() is calling this function with safe ==
false so those statements would never check anything. I guess that's
still ok because the above intel_find_matching_signature() would match.

Hmmm?

Uff, this function is ugly and can be simplified. Perhaps that happens
later.


>  
> -		/* We have a newer patch, save it. */
>  		patch = data;
> +		cur_rev = mc_header->rev;
>  
>  next:
>  		data += mc_size;
> @@ -374,18 +304,22 @@ scan_microcode(void *data, size_t size,
>  	if (size)
>  		return NULL;
>  
> +	if (save && patch)
> +		save_microcode_patch(patch, mc_size);
> +
>  	return patch;
>  }
>  
>  static void show_saved_mc(void)
>  {
>  #ifdef DEBUG

Yeah, what Nikolay said - move the next one before this one and then the
show_saved_mc() hunks are gone.

> -	int i = 0, j;
>  	unsigned int sig, pf, rev, total_size, data_size, date;
> +	struct extended_sigtable *ext_header;
> +	struct extended_signature *ext_sig;
>  	struct ucode_cpu_info uci;
> -	struct ucode_patch *p;
> +	int j, ext_sigcount;
>  
> -	if (list_empty(&microcode_cache)) {
> +	if (!intel_ucode_patch) {
>  		pr_debug("no microcode data saved.\n");
>  		return;
>  	}

...

> @@ -451,7 +374,7 @@ static void save_mc_for_early(struct uco
>  
>  	mutex_lock(&x86_cpu_microcode_mutex);
>  
> -	save_microcode_patch(uci, mc, size);
> +	save_microcode_patch(mc, size);
>  	show_saved_mc();
>  
>  	mutex_unlock(&x86_cpu_microcode_mutex);
> @@ -675,26 +598,10 @@ void load_ucode_intel_ap(void)
>  	apply_microcode_early(&uci, true);
>  }
>  
> -static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)
> +/* Accessor for microcode pointer */
> +static struct microcode_intel *ucode_get_patch(void)

static function - "get_patch" only is fine.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
