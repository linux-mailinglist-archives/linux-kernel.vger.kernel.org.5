Return-Path: <linux-kernel+bounces-129982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18578972D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDF0284F73
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EFA139CF5;
	Wed,  3 Apr 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GUHFXP8w"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071D58AD4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155192; cv=none; b=dDtcU4Kt1CkhVOZclmBGAle6+IGlIUhw4Key1owGoiOyHutl315ipIBTp8+ytFNO+6zx1cqpQYEfmRpENZNggdMgwf/jYvG05uzsWTOu7eRlmid7XOY0NdmdeBIVkSH76z+4x1JIppBu2SlRDZZMcGMJkBRtfOElEEA67MC9u+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155192; c=relaxed/simple;
	bh=5WRZA+Dr0y7K8BNMTXM69RHs/uBHis89yH3S75lrVoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLhi7+iI/cWm1pWmWmElVreVFTwSRozaRLrW0lDn97D7xrfSxco5HM/IQP/WZN1KxKI2lMGaPeeXuHk5SbsDu5k7enx4ZH4C8jXvHxZpTYLdOOAWgJoTMaMYCB8f3H5uzVw//R+EM0UIJq83IYkbkigfi2EQm4KbRt6bsf4bWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GUHFXP8w; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ff53528ceso4570091f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712155188; x=1712759988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FklsZuM90rznRBFLrrNtkklczLk3WQXoeuBMkIdc+sw=;
        b=GUHFXP8wM0ZNbJbzlnWdOtCyOpchY5SUq5iQv+6PUMiuHfhTt0UFLKhGqnRcHSGurc
         awI23RSWMQQtkv/ekuLnzGAEtNPv0fNjLiRw9cJ/5aBaGBeJxeh09OA9cXAU2nDQmpP2
         qlpyxVUmHyNsVGrygm9ayxcJGjmqgetNoZbruwzsTNEdJQxS68INMg0GbNoba+1Mkmod
         vY1G3tJyBRX6XXTM3rt8E9xDTm21mJchY3WFrhY9r4g67MhXqNuQPXx7uaxy4SXFiYht
         n8DIXi42RNuokB0Z2YwzEeql+7rRenzGWs9ZLP6qIA7O0GLwu/lIFE72FkceHx5YKxBC
         ehSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712155188; x=1712759988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FklsZuM90rznRBFLrrNtkklczLk3WQXoeuBMkIdc+sw=;
        b=iWu6JC/+J/H8gcKbedYGoBl8WBSWFYNQxxPQTZxFCs/IlIn/+sxFTZaPlMn9gaPyz/
         FPjmiPjqFIIgiGWoyElbJBpQ58FqxfTf3/1XCI6/A9jwwaYcOD1esLodS8OYMVlOOGjf
         zyEdZKaaMfjFm5rAlu1v4ogArPgB01DhTysrvunYSfplfUfJrzuE3uzyubboI4RFKeGF
         WvzyMgz0I1yN3ioswWx9IoJ8mSSmCxASeTnD9Zj+9LgqCLfKjUad79wzDazeG/jG+jhH
         shlTQIzDUIKU4ak7JgaAjFo6TRu+IRuBjBAIYXEYad/zhpW3fGV8L0KQQEyk9tk1/1ff
         3uwg==
X-Forwarded-Encrypted: i=1; AJvYcCXVptNjRQv7jLIUIY8jGGBORSvkSFZO73QjHVOplM2DPXDnEKfAAsEXXVTeVHfOU/e0JbKIFemQDfP7pdIZlL2CXug7qsFxfW0MaTLF
X-Gm-Message-State: AOJu0YzrsysZ+qvteW3x6ySBiRLnCX8VqQnCazBAXosxy3YDy1p6f/mR
	ndU+rR/3icOsOKnalEYEVhW0BsDa8cwMgTZ3Vnp/y35uZqVQooU42sJzKbJbZCD8IMMIc/M7RTi
	9iw==
X-Google-Smtp-Source: AGHT+IE0XU9qxmp/M9iPgXeb9rRKuNSCPxPTPloUyHTQq1k1QWzd/q67ITtUheE9vPqlgNtysOX9mA==
X-Received: by 2002:adf:fac8:0:b0:341:d765:8715 with SMTP id a8-20020adffac8000000b00341d7658715mr1935030wrs.35.1712155188365;
        Wed, 03 Apr 2024 07:39:48 -0700 (PDT)
Received: from google.com (161.126.77.34.bc.googleusercontent.com. [34.77.126.161])
        by smtp.gmail.com with ESMTPSA id az15-20020adfe18f000000b0034335f13570sm15409592wrb.116.2024.04.03.07.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:39:47 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:39:44 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-mm@kvack.org
Subject: Re: [PATCH v19 RESEND 3/5] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <Zg1qMI7JYhdeY_z7@google.com>
References: <20240326100830.1326610-1-vdonnefort@google.com>
 <20240326100830.1326610-4-vdonnefort@google.com>
 <20240329144055.0ae2dd4b@gandalf.local.home>
 <20240403101352.08c83aa4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403101352.08c83aa4@gandalf.local.home>

On Wed, Apr 03, 2024 at 10:13:52AM -0400, Steven Rostedt wrote:
> On Fri, 29 Mar 2024 14:40:55 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > +static vm_fault_t tracing_buffers_mmap_fault(struct vm_fault *vmf)
> > > +{
> > > +	return VM_FAULT_SIGBUS;
> > > +}  
> > 
> > If this is all it does, I don't believe it's needed.
> > 
> > > +
> > > +#ifdef CONFIG_TRACER_MAX_TRACE
> > > +static int get_snapshot_map(struct trace_array *tr)
> > > +{
> > > +	int err = 0;
> > > +
> > > +	/*
> > > +	 * Called with mmap_lock held. lockdep would be unhappy if we would now
> > > +	 * take trace_types_lock. Instead use the specific
> > > +	 * snapshot_trigger_lock.
> > > +	 */
> > > +	spin_lock(&tr->snapshot_trigger_lock);
> > > +
> > > +	if (tr->snapshot || tr->mapped == UINT_MAX)
> > > +		err = -EBUSY;
> > > +	else
> > > +		tr->mapped++;
> > > +
> > > +	spin_unlock(&tr->snapshot_trigger_lock);
> > > +
> > > +	/* Wait for update_max_tr() to observe iter->tr->mapped */
> > > +	if (tr->mapped == 1)
> > > +		synchronize_rcu();
> > > +
> > > +	return err;
> > > +
> > > +}
> > > +static void put_snapshot_map(struct trace_array *tr)
> > > +{
> > > +	spin_lock(&tr->snapshot_trigger_lock);
> > > +	if (!WARN_ON(!tr->mapped))
> > > +		tr->mapped--;
> > > +	spin_unlock(&tr->snapshot_trigger_lock);
> > > +}
> > > +#else
> > > +static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
> > > +static inline void put_snapshot_map(struct trace_array *tr) { }
> > > +#endif
> > > +
> > > +static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
> > > +{
> > > +	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> > > +	struct trace_iterator *iter = &info->iter;
> > > +
> > > +	WARN_ON(ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file));
> > > +	put_snapshot_map(iter->tr);
> > > +}
> > > +
> > > +static void tracing_buffers_mmap_open(struct vm_area_struct *vma) { }  
> > 
> > Same for the open.
> > 
> > 
> > > +
> > > +static const struct vm_operations_struct tracing_buffers_vmops = {
> > > +	.open		= tracing_buffers_mmap_open,
> > > +	.close		= tracing_buffers_mmap_close,
> > > +	.fault		= tracing_buffers_mmap_fault,
> > > +};  
> > 
> > I replaced this with:
> > 
> > static const struct vm_operations_struct tracing_buffers_vmops = {
> > 	.close		= tracing_buffers_mmap_close,
> > };
> > 
> > And it appears to work just fine. The mm code handles the NULL cases for
> > .open and .fault.
> > 
> > Is there any reason to do something different than the mm defaults?

No other reason here than my own ignorance. I will remove.

> 
> Hi Vincent,
> 
> Do you plan on sending out a v20 series?

Of course, let me spin that this week! Got also few typos to fix in the doc and
I believe an include missing for riscv.

> 
> -- Steve

