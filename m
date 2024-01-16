Return-Path: <linux-kernel+bounces-27751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F97682F554
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B321C239B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E0F1D525;
	Tue, 16 Jan 2024 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDl1Rx/+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2953B1D520
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433245; cv=none; b=B48PGBaK1NiK8ytxWmSpfLJ1tjWhdIU6RCv7NI46w+H/fuoPRsmCCplxZ67+ugf2rrd5zv9CIvFEjj6txXvjK0HvH7hMXf6BfVxt77ZsyKtEpsbzm9ZnB4nYHPGJMvdgFe/Ed6cU+C5TIdhxP6dnxjbGScWVt0DvPXl2A7EgIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433245; c=relaxed/simple;
	bh=HuCrJZo35r6ruH/amqCmbbDb7MvxiW0LNgoZe2NK7ZM=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding; b=iW0CTc8PNXXqBMOb9xQfzrVjXtfSbRBO0e7csXXVsoXv1YETIFtxYrgQPfGBSj+ouLCgswtPXOZSYu8Rvhz1JtY5GAagbRUdWi6LqojXcZoPfGFelHGMBqeTewCW5EeIzg04ad1Cm8oQBEkeagzKTNkskBfxDgzKFvWmSpQbbqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDl1Rx/+; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705433242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esJyrwZ7t8TfGpWfViV1tydHUavaxnEyVLYlf+MWBAY=;
	b=TDl1Rx/+SJmwHQQr6cDVmiGCVQVkRIT8YMCDZINiUB+I/5trnGYpZEGVp3+YPvZe4GW01n
	vcGYRN/VBT2hgBrmi2qJjF5UAK3cbp6XQaBKj8CJHOkG+SmQvYsKCIa7guSuap+DXoaNuy
	5663Nz1cIzSCSfwVaeuPnRT8aZVQwbo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-NK98I2zLOealYB_x2D8d5A-1; Tue, 16 Jan 2024 14:27:20 -0500
X-MC-Unique: NK98I2zLOealYB_x2D8d5A-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-429a7149210so83022721cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705433240; x=1706038040;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=esJyrwZ7t8TfGpWfViV1tydHUavaxnEyVLYlf+MWBAY=;
        b=SPIVffzXqj2EoN2+ZpNiaCPdZi+JFrhAaVbJ8q/D1EE8KrMrk2lztYsbplQyfmXcp2
         89CpxgB9mdVBT6hyJO6Z36OEzoue0OE0BpKgRHJMQvYc8fS0x8h7Iu5HHdmLpY4cruqq
         uwZ/gpMbNSnDRq4rrvKFRmUR9ZYPl2qtuPkQldvG5NgD6PWnZpB4f8t1E/GqIG3//jVu
         Ranjl5IZbGP5x+bxia8F60urNdJdNN/fuzyb1WuO7+AtRRDQnhOqAfcNAF1er2AuCSMR
         HW/Yhrv3kEHJsNto/rFcralfN+MUdEftUaXlQ/JhgmlwBmLY+EAyzXVPBsfx/842QZZb
         dH1Q==
X-Gm-Message-State: AOJu0YzJwuYjbyxbtVL4cohD2cUfPPDau6VIvmznFDaLLNBZZ8bbYSeY
	hPk0bxGDNDe1sGTupzloOC9XhDqAS7dasozC4IuCYwGS2MLVmPCG7gqgJlSsQbCBr/ePfjPgkwJ
	fzq8gKBqxwk8yQ98+Kwla888IYifUo4E2
X-Received: by 2002:a05:622a:178d:b0:429:ae56:5ae3 with SMTP id s13-20020a05622a178d00b00429ae565ae3mr8394145qtk.85.1705433239996;
        Tue, 16 Jan 2024 11:27:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS3fShy/i2zdxIwBWrU8CA6ttXbmT5UHLBUfFpZeqsNOaTW+nsjukhTUs/vzO0Uaayz0DNVQ==
X-Received: by 2002:a05:622a:178d:b0:429:ae56:5ae3 with SMTP id s13-20020a05622a178d00b00429ae565ae3mr8394137qtk.85.1705433239700;
        Tue, 16 Jan 2024 11:27:19 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id fw6-20020a05622a4a8600b00427f89957d9sm5108195qtb.79.2024.01.16.11.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:27:19 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 1/5] riscv/cmpxchg: Deduplicate xchg() asm functions
Date: Tue, 16 Jan 2024 16:27:07 -0300
Message-ID: <ZabYi5NoTiXJ4Hf2@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202401131438.f8SELM0W-lkp@intel.com>
References: <20240103163203.72768-3-leobras@redhat.com> <202401131438.f8SELM0W-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Jan 13, 2024 at 02:54:17PM +0800, kernel test robot wrote:
> Hi Leonardo,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 610a9b8f49fbcf1100716370d3b5f6f884a2835a]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Leonardo-Bras/riscv-cmpxchg-Deduplicate-xchg-asm-functions/20240104-003501

Cloned this repo

> base:   610a9b8f49fbcf1100716370d3b5f6f884a2835a
> patch link:    https://lore.kernel.org/r/20240103163203.72768-3-leobras%40redhat.com
> patch subject: [PATCH v1 1/5] riscv/cmpxchg: Deduplicate xchg() asm functions
> config: riscv-randconfig-r111-20240112 (https://download.01.org/0day-ci/archive/20240113/202401131438.f8SELM0W-lkp@intel.com/config)
> compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)
> reproduce: (https://download.01.org/0day-ci/archive/20240113/202401131438.f8SELM0W-lkp@intel.com/reproduce)

And followed those instructions, while using sparse v0.6.4-52-g1cf3d98c.

> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401131438.f8SELM0W-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> net/ipv4/tcp_cong.c:300:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct tcp_congestion_ops const [noderef] __rcu *__new @@     got struct tcp_congestion_ops *[assigned] ca @@
>    net/ipv4/tcp_cong.c:300:24: sparse:     expected struct tcp_congestion_ops const [noderef] __rcu *__new
>    net/ipv4/tcp_cong.c:300:24: sparse:     got struct tcp_congestion_ops *[assigned] ca
>    net/ipv4/tcp_cong.c:300:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct tcp_congestion_ops const *prev @@     got struct tcp_congestion_ops const [noderef] __rcu * @@
>    net/ipv4/tcp_cong.c:300:22: sparse:     expected struct tcp_congestion_ops const *prev
>    net/ipv4/tcp_cong.c:300:22: sparse:     got struct tcp_congestion_ops const [noderef] __rcu *
>    net/ipv4/tcp_cong.c: note: in included file (through include/linux/module.h):
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
> 
> vim +300 net/ipv4/tcp_cong.c
> 
> 317a76f9a44b43 Stephen Hemminger 2005-06-23  281  
> 317a76f9a44b43 Stephen Hemminger 2005-06-23  282  /* Used by sysctl to change default congestion control */
> 6670e152447732 Stephen Hemminger 2017-11-14  283  int tcp_set_default_congestion_control(struct net *net, const char *name)
> 317a76f9a44b43 Stephen Hemminger 2005-06-23  284  {
> 317a76f9a44b43 Stephen Hemminger 2005-06-23  285  	struct tcp_congestion_ops *ca;
> 6670e152447732 Stephen Hemminger 2017-11-14  286  	const struct tcp_congestion_ops *prev;
> 6670e152447732 Stephen Hemminger 2017-11-14  287  	int ret;
> 317a76f9a44b43 Stephen Hemminger 2005-06-23  288  
> 6670e152447732 Stephen Hemminger 2017-11-14  289  	rcu_read_lock();
> 6670e152447732 Stephen Hemminger 2017-11-14  290  	ca = tcp_ca_find_autoload(net, name);
> 6670e152447732 Stephen Hemminger 2017-11-14  291  	if (!ca) {
> 6670e152447732 Stephen Hemminger 2017-11-14  292  		ret = -ENOENT;
> 0baf26b0fcd74b Martin KaFai Lau  2020-01-08  293  	} else if (!bpf_try_module_get(ca, ca->owner)) {
> 6670e152447732 Stephen Hemminger 2017-11-14  294  		ret = -EBUSY;
> 8d432592f30fcc Jonathon Reinhart 2021-05-01  295  	} else if (!net_eq(net, &init_net) &&
> 8d432592f30fcc Jonathon Reinhart 2021-05-01  296  			!(ca->flags & TCP_CONG_NON_RESTRICTED)) {
> 8d432592f30fcc Jonathon Reinhart 2021-05-01  297  		/* Only init netns can set default to a restricted algorithm */
> 8d432592f30fcc Jonathon Reinhart 2021-05-01  298  		ret = -EPERM;
> 6670e152447732 Stephen Hemminger 2017-11-14  299  	} else {
> 6670e152447732 Stephen Hemminger 2017-11-14 @300  		prev = xchg(&net->ipv4.tcp_congestion_control, ca);
> 6670e152447732 Stephen Hemminger 2017-11-14  301  		if (prev)
> 0baf26b0fcd74b Martin KaFai Lau  2020-01-08  302  			bpf_module_put(prev, prev->owner);
> 317a76f9a44b43 Stephen Hemminger 2005-06-23  303  
> 6670e152447732 Stephen Hemminger 2017-11-14  304  		ca->flags |= TCP_CONG_NON_RESTRICTED;
> 317a76f9a44b43 Stephen Hemminger 2005-06-23  305  		ret = 0;
> 317a76f9a44b43 Stephen Hemminger 2005-06-23  306  	}
> 6670e152447732 Stephen Hemminger 2017-11-14  307  	rcu_read_unlock();
> 317a76f9a44b43 Stephen Hemminger 2005-06-23  308  
> 317a76f9a44b43 Stephen Hemminger 2005-06-23  309  	return ret;
> 317a76f9a44b43 Stephen Hemminger 2005-06-23  310  }
> 317a76f9a44b43 Stephen Hemminger 2005-06-23  311  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

I did some testing using the instructions above on above file, and patch 
1/5 haven't introduced anything new.


Command for gathering sparse warnings:
COMPILER_INSTALL_PATH=$HOME/0day ~/lkp-tests/kbuild/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__ -fmax-errors=unlimited -fmax-warnings=unlimited' O=build_dir ARCH=riscv SHELL=/bin/bash net/ipv4/tcp_cong.o 2> sparse

I ran this for the commit mentioned in the reproduction instructions 
(7931dc023 : riscv/cmpxchg: Deduplicate xchg() asm functions ) and for it's 
parent (610a9b8f49 : Linux 6.7-rc8). The diff -u on the output was:

# diff -u sparse_vanilla sparse_p1_5    
--- sparse_vanilla      2024-01-16 14:16:36.217965076 -0500              
+++ sparse_p1_5 2024-01-16 14:15:29.942712160 -0500                      
@@ -1,5 +1,5 @@                                                          
 ../net/ipv4/tcp_cong.c:300:24: sparse: warning: incorrect type in initializer (different address spaces)
-../net/ipv4/tcp_cong.c:300:24: sparse:    expected struct tcp_congestion_ops const [noderef] __rcu *_x_
+../net/ipv4/tcp_cong.c:300:24: sparse:    expected struct tcp_congestion_ops const [noderef] __rcu *__new
 ../net/ipv4/tcp_cong.c:300:24: sparse:    got struct tcp_congestion_ops *[assigned] ca
 ../net/ipv4/tcp_cong.c:300:22: sparse: warning: incorrect type in assignment (different address spaces)
 ../net/ipv4/tcp_cong.c:300:22: sparse:    expected struct tcp_congestion_ops const *prev

So I did not introduce anything new, as per sparse v0.6.4-52-g1cf3d98c .

I noticed the output is slightly different, and that in the reproduction 
steps this used:
# sparse version: v0.6.4-52-g1cf3d98c-dirty

Since there is no indicator on what the -dirty stands for, it's hard for me 
to get the same reproduction, but as far as I could test there is not 
any new error. 

Thanks!
Leo



