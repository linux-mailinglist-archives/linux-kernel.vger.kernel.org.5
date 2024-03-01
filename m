Return-Path: <linux-kernel+bounces-87739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBCE86D861
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E0BB228C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04F33C9;
	Fri,  1 Mar 2024 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="p3XOsS5L"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7AA2570
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253349; cv=none; b=EYwzc7gd5CNEP0M5aBQtOz87tN32wZGPJzTVWtUnnjC4K5C3cMnOrOGozlJyDs16yPH6t8VF0wNV+ecJfutUcXqSXpEf4xJCYj2XVGFYV0JnAqZTNgeVp6aAjOxTti2cvIip++05k8Gq3agXQZSV3H8cHZxHZ3tW2adadGS6q/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253349; c=relaxed/simple;
	bh=QK09S2sQlJEZw4sA/tOf9ak1RVvkN27Q6uYXIdV/I1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PatLCfv+FGDsRqxNb0hi5E/xiGp1lN2RZPSXL0tTgO28Ye2qT7RkfmccgbrC4yExYOJAx1kodZUjtBizIwdbqn7zwzCAzdMh3eFPlIBI6Vdt1vtou3ijX5UiTskVAcgpdlXezdPy9gTAFL9y0kLBmkHrUxk3ef+2CuC+NPvBT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=p3XOsS5L; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso857693f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1709253346; x=1709858146; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QK09S2sQlJEZw4sA/tOf9ak1RVvkN27Q6uYXIdV/I1o=;
        b=p3XOsS5Lfa3ZVTuRFm1MxWAl1KFZnSgQSHTCXmSfNzjXZEOWvHQtygbRg2v8gdA9N2
         E1fjp+A+IHBWaEihZ/SKshPWjBPyhV4qzbLavWLOaT+aa2+UkmWdwLshcE7XvazF6pVD
         GDfobR7jP6bF9Min566uDlFM4xH21jNc8dr0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709253346; x=1709858146;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QK09S2sQlJEZw4sA/tOf9ak1RVvkN27Q6uYXIdV/I1o=;
        b=q0lmuWScOHOAVQTbeQAxHA5RWyuo1euF2aSmDskBiHHSDPh3DEmvzattxtxdLLYiS+
         0iOHxcl17HyLySK4p6leZp6KU9/V3LypwKZ9ovs5H4yeV6xedTFxx81NlehkfbVvUaF0
         uKGi5JhASp2vsnuJPbpg5ORvPUw2c9pjKo45Zulwdq5Ada2w/XzaxYJa5kVlIdMCj01V
         2sIvMhPnxfC937vbN3BSoALrma7/GPc19FyGcCJ9bEqyEI1aPtMD3X6GlVd7sOenkoVH
         LuLK0yadwf12WkkGNVB3mwK3gME+F1tVFPQRWArjOo7ACFQY1oldjbXgpXLVYJhG1lb6
         86xw==
X-Forwarded-Encrypted: i=1; AJvYcCV13kPu7Kp54MmEe6qhZijHSfc+D90uc8XjFXjJmpCjrnmkVc/oDS4LHZEwyJVkR3IIVd6yUnHkxsiC9YxIqDEG2kHJofAUSQ9iZAKy
X-Gm-Message-State: AOJu0YzvOxc+/wtmDqjnaLzFoPYCCWXC9LSOdoaMArn3+4t58ZiPBQ2Q
	bNMKfLarFfbm74Jazjwc3MgYJPvksiF65d7s5H868IDLVYKeesO8eEPfKUeJ3H4=
X-Google-Smtp-Source: AGHT+IEs3jQqAEI9fhp8IrVWdqsd9p5aKEl5FnIoeYTO8e2QwM3b2IqegwDgcnJ2DgoxInfDkD775w==
X-Received: by 2002:adf:9d89:0:b0:33d:eb13:9e27 with SMTP id p9-20020adf9d89000000b0033deb139e27mr80509wre.23.1709253345710;
        Thu, 29 Feb 2024 16:35:45 -0800 (PST)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d50ce000000b0033b66c2d61esm3014534wrt.48.2024.02.29.16.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:35:45 -0800 (PST)
Date: Fri, 1 Mar 2024 00:35:44 +0000
From: Chris Down <chris@chrisdown.name>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Petr Mladek <pmladek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jessica Yu <jeyu@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH 0/4] printk_index: Fix false positives
Message-ID: <ZeEi4IhVSh41cWYS@chrisdown.name>
References: <cover.1709127473.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1709127473.git.geert+renesas@glider.be>
User-Agent: Mutt/2.2.12 (2023-09-09)

Thanks for working on this! This whole patchset looks good to me.

Reviewed-by: Chris Down <chris@chrisdown.name>

