Return-Path: <linux-kernel+bounces-44384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30104842152
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF74B25F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945F460DD6;
	Tue, 30 Jan 2024 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrURb1VB"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B3360AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610776; cv=none; b=EOdTdHMrhQuCPzSOZYzD+TWnU9aMKkbJAFbxXk++ZSlnghbKiwIeezjzO8IKAdg/It2SGZ+W6AH8GHOvoZ/DbzG6RvmQnHXs7h8qAeFiCLKXnR1apyGupJlR7SRPvqB9hszI2G4IGwZ/MUQEbvQ6IqqA99UO1zCaMMzWnQ/ErJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610776; c=relaxed/simple;
	bh=T8YocdfcR21pd5ihCsAeQ/OPqAW1R3GuUg5zJ4h+d/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpekYoAUkVvaFr+s7gOt4zdFGdclSFW/V2yjy0XubReBjgDHhoIeYDm9kx++2O1iBm6ZNqnecVc5s0JruKjDotMW5lYWvyBfVh8RXirEjeIr5j2ViRt27yb9aXw+Wr7R/kylFCKVtJ4W3/6S3DMEtazbJAANJ+srIotsGalRgq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UrURb1VB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ef6da20feso11033725e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706610772; x=1707215572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJy2oY5sSa5dpMNL2tlno0bYtkBbusko6D5boAApUTk=;
        b=UrURb1VB8WNnZlzoG+CMAISDb/+edIcCOzH2xpWD5DmBHFK+y3IRTM5a0OCZHC9K2t
         m7K/N9Yqbe0Fq4GKtwLF799KzHBime3OfXFUIwsC+VNmFR7Vs+5M0hscXnllu321BS/K
         9EZDAC4O/jBQXeYIRUzCYC+i9F0kirjj1eJAxd+IREL3AgzjCfAuKXj8cM4hNK9HC+vu
         A7pUfa2wVjGYmA0i/CsnnrBifETJ2kH/90TeLWr0mI6GRyoRhHB6iNFEcjuW1Oods5w0
         kakwfBam0sK44/EW8VNRWgkxwzjHC/OsmhX4i2uCzDVYA6UhyBd5aAv5j2uWb9SDYHWn
         rkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706610772; x=1707215572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJy2oY5sSa5dpMNL2tlno0bYtkBbusko6D5boAApUTk=;
        b=ZnRWPIYwYRysDfnVqdviKzaDOxmBtquBYlKgv6kgbeCO4OGWHNl2dQDGvuDe+Bx6oo
         yr10QUDVbk5Mx6CFGPbMn6oq5ixbLI8bc/ri6UwxmP9yo1nUVElOmt4Y1QQoj1RP+scl
         x6jRUgyY2xJD2a/BNJ72kSdF2/hb0xpOZ4jieUhbXihNZWvD0A/3Meq9VaQT/MKSZncn
         X5xDjW10moaDPdqo7FY8oaP2XGMNaHcmnn2cvhH81B9ka64LOYFVTsXXrqWkgFP0r0gh
         rnPc2u+E8pDLxzXS6JpxQ5/Dlwoa3qdLmA1dXlyIvJLV8OOS82KW96X2QdTDpnoJhy/R
         8Lsg==
X-Gm-Message-State: AOJu0YzdkCIGbKHrEuiy0KJEbtlu4cu5WpXt2K1unb9HWaJKQS1r/kVV
	fzQ7l8oBffKdq0zuyYhlbiy1lZh6t+Hvy5RRU7tNXzbpv7O6Qdd9DxBJsScpkQ==
X-Google-Smtp-Source: AGHT+IFeqsWf8yGfkeST6DbWjfbRh7I1RsszM1c7991rKwNqILlVIe5QTUm8OTMctrmeYqClxLEdyQ==
X-Received: by 2002:a05:600c:3510:b0:40f:aabd:b83 with SMTP id h16-20020a05600c351000b0040faabd0b83mr485777wmq.13.1706610771692;
        Tue, 30 Jan 2024 02:32:51 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b0040ef702a338sm5538522wmq.25.2024.01.30.02.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:32:51 -0800 (PST)
Date: Tue, 30 Jan 2024 10:32:45 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: kernel test robot <lkp@intel.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	mathieu.desnoyers@efficios.com, kernel-team@android.com
Subject: Re: [PATCH v13 3/6] tracing: Add snapshot refcount
Message-ID: <ZbjQTZ4SIkG703QM@google.com>
References: <20240129142802.2145305-4-vdonnefort@google.com>
 <202401301740.qzZlpcYV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401301740.qzZlpcYV-lkp@intel.com>

On Tue, Jan 30, 2024 at 05:30:38PM +0800, kernel test robot wrote:
> Hi Vincent,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 29142dc92c37d3259a33aef15b03e6ee25b0d188]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Donnefort/ring-buffer-Zero-ring-buffer-sub-buffers/20240129-223025
> base:   29142dc92c37d3259a33aef15b03e6ee25b0d188
> patch link:    https://lore.kernel.org/r/20240129142802.2145305-4-vdonnefort%40google.com
> patch subject: [PATCH v13 3/6] tracing: Add snapshot refcount
> config: arc-randconfig-002-20240130 (https://download.01.org/0day-ci/archive/20240130/202401301740.qzZlpcYV-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240130/202401301740.qzZlpcYV-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401301740.qzZlpcYV-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/trace/trace.c: In function 'tracing_set_tracer':
>    kernel/trace/trace.c:6644:17: error: implicit declaration of function 'tracing_disarm_snapshot_locked'; did you mean 'tracing_disarm_snapshot'? [-Werror=implicit-function-declaration]
>     6644 |                 tracing_disarm_snapshot_locked(tr);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                 tracing_disarm_snapshot
> >> kernel/trace/trace.c:6648:23: error: implicit declaration of function 'tracing_arm_snapshot_locked'; did you mean 'tracing_arm_snapshot'? [-Werror=implicit-function-declaration]
>     6648 |                 ret = tracing_arm_snapshot_locked(tr);
>          |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                       tracing_arm_snapshot
>    cc1: some warnings being treated as errors

Right, two tracers (hwlat and osnoise) select _only_ MAX_TRACE and not
TRACER_SNAPSHOT.

However, AFAICT, they will not call any of the swapping functions (they don't
set use_max_tr). So I suppose arm/disarm can be ommited in that case.

> 
> 
> vim +6648 kernel/trace/trace.c
> 
>   6560	
>   6561	int tracing_set_tracer(struct trace_array *tr, const char *buf)
>   6562	{
>   6563		struct tracer *t;
>   6564	#ifdef CONFIG_TRACER_MAX_TRACE
>   6565		bool had_max_tr;
>   6566	#endif
>   6567		int ret = 0;
>   6568	
>   6569		mutex_lock(&trace_types_lock);
>   6570	
>   6571		if (!tr->ring_buffer_expanded) {
>   6572			ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
>   6573							RING_BUFFER_ALL_CPUS);
>   6574			if (ret < 0)
>   6575				goto out;
>   6576			ret = 0;
>   6577		}
>   6578	
>   6579		for (t = trace_types; t; t = t->next) {
>   6580			if (strcmp(t->name, buf) == 0)
>   6581				break;
>   6582		}
>   6583		if (!t) {
>   6584			ret = -EINVAL;
>   6585			goto out;
>   6586		}
>   6587		if (t == tr->current_trace)
>   6588			goto out;
>   6589	
>   6590	#ifdef CONFIG_TRACER_SNAPSHOT
>   6591		if (t->use_max_tr) {
>   6592			local_irq_disable();
>   6593			arch_spin_lock(&tr->max_lock);
>   6594			if (tr->cond_snapshot)
>   6595				ret = -EBUSY;
>   6596			arch_spin_unlock(&tr->max_lock);
>   6597			local_irq_enable();
>   6598			if (ret)
>   6599				goto out;
>   6600		}
>   6601	#endif
>   6602		/* Some tracers won't work on kernel command line */
>   6603		if (system_state < SYSTEM_RUNNING && t->noboot) {
>   6604			pr_warn("Tracer '%s' is not allowed on command line, ignored\n",
>   6605				t->name);
>   6606			goto out;
>   6607		}
>   6608	
>   6609		/* Some tracers are only allowed for the top level buffer */
>   6610		if (!trace_ok_for_array(t, tr)) {
>   6611			ret = -EINVAL;
>   6612			goto out;
>   6613		}
>   6614	
>   6615		/* If trace pipe files are being read, we can't change the tracer */
>   6616		if (tr->trace_ref) {
>   6617			ret = -EBUSY;
>   6618			goto out;
>   6619		}
>   6620	
>   6621		trace_branch_disable();
>   6622	
>   6623		tr->current_trace->enabled--;
>   6624	
>   6625		if (tr->current_trace->reset)
>   6626			tr->current_trace->reset(tr);
>   6627	
>   6628	#ifdef CONFIG_TRACER_MAX_TRACE
>   6629		had_max_tr = tr->current_trace->use_max_tr;
>   6630	
>   6631		/* Current trace needs to be nop_trace before synchronize_rcu */
>   6632		tr->current_trace = &nop_trace;
>   6633	
>   6634		if (had_max_tr && !t->use_max_tr) {
>   6635			/*
>   6636			 * We need to make sure that the update_max_tr sees that
>   6637			 * current_trace changed to nop_trace to keep it from
>   6638			 * swapping the buffers after we resize it.
>   6639			 * The update_max_tr is called from interrupts disabled
>   6640			 * so a synchronized_sched() is sufficient.
>   6641			 */
>   6642			synchronize_rcu();
>   6643			free_snapshot(tr);
>   6644			tracing_disarm_snapshot_locked(tr);
>   6645		}
>   6646	
>   6647		if (t->use_max_tr) {
> > 6648			ret = tracing_arm_snapshot_locked(tr);
>   6649			if (ret)
>   6650				goto out;
>   6651		}
>   6652	#else
>   6653		tr->current_trace = &nop_trace;
>   6654	#endif
>   6655	
>   6656		if (t->init) {
>   6657			ret = tracer_init(t, tr);
>   6658			if (ret) {
>   6659	#ifdef CONFIG_TRACER_MAX_TRACE
>   6660				if (t->use_max_tr)
>   6661					tracing_disarm_snapshot_locked(tr);
>   6662	#endif
>   6663				goto out;
>   6664			}
>   6665		}
>   6666	
>   6667		tr->current_trace = t;
>   6668		tr->current_trace->enabled++;
>   6669		trace_branch_enable(tr);
>   6670	 out:
>   6671		mutex_unlock(&trace_types_lock);
>   6672	
>   6673		return ret;
>   6674	}
>   6675	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

