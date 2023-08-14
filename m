Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B8077B9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHNNUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjHNNTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:19:45 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC81171F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:19:41 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6391740E019C;
        Mon, 14 Aug 2023 13:19:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WeDv0xOEnKWr; Mon, 14 Aug 2023 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692019177; bh=hmFKq3V/EZ3Nm7G6kVtuUkxiygUxy3BSLR5WSpdj8zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chKUoEYoveUopt8m5v27wDw41N0HrpwUySG6Y6ltesnEBSHinL+PAp6YQOSD69Pee
         LtaEYt2p3uiH9znityUbs65TjkeDFsL/ORWbCGI4k1B5BiHbEpWvJRy6taNiIgeuOh
         L/gJSCN/ThqiQAEFWwoQHJC5eOIfPM484SNv+Y+463A4QmdTZbE+pU2cM2qcD7oT4I
         v3M5hFkc2tEEdA6SiUjwSnknRUzzyZ7809vLlWce1eYFhFFavCugtT5W4PSPIkcjCW
         hXiJfY5vj8hBjwCODJaGExdhXxZsSosAznBJGxvu+G47lxuPNKl89RtRV6GbB9sJvq
         6c5IYmYPmD3ndOpPbx641z2ZMD3L3Jh9PlceAIhtSCOBdt51gKe8DXpLKPZ+p2L84p
         yZI1LCGN5kIhSZO/4r9+h9GPdboTus4z/doXovsMOcQI4jYsJMGVhssNywNK++7XQU
         tK+6UNzG87A5CFlJK7EjIJP9S0GSjuDkdJg8JgmKsAX6r89vN61X82oii5VJPvK8WG
         D8qdtduR2TfwnR7zfbwTECTsoIgreWx571KM8t9XcoUBqeUaF0HiZY1OkGBlMUcxlf
         L0THayN56qJh3R25k7gcNNsiprS8RWuJIE9IomDDGOvWOIZpnASBJHEQioIVc/EdnJ
         4yWDBVntL/GvJeKk1VZNydwM=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76CC640E0195;
        Mon, 14 Aug 2023 13:19:31 +0000 (UTC)
Date:   Mon, 14 Aug 2023 15:19:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V2 12/37] x86/microcode/intel: Simplify and rename
 generic_load_microcode()
Message-ID: <20230814131927.GEZNop39tb9LxSjFLK@fat_crate.local>
References: <20230812194003.682298127@linutronix.de>
 <20230812195728.246048244@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230812195728.246048244@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 09:58:55PM +0200, Thomas Gleixner wrote:
> @@ -645,14 +632,12 @@ static enum ucode_state apply_microcode_
>  	return ret;
>  }
>  
> -static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
> +static enum ucode_state read_ucode_intel(int cpu, struct iov_iter *iter)

I'd do this ontop:

---
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 2b49637778be..a45ecbab5137 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -632,7 +632,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	return ret;
 }
 
-static enum ucode_state read_ucode_intel(int cpu, struct iov_iter *iter)
+static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
@@ -758,7 +758,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
 	kvec.iov_base = (void *)firmware->data;
 	kvec.iov_len = firmware->size;
 	iov_iter_kvec(&iter, ITER_SOURCE, &kvec, 1, firmware->size);
-	ret = read_ucode_intel(cpu, &iter);
+	ret = parse_microcode_blobs(cpu, &iter);
 
 	release_firmware(firmware);
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
