Return-Path: <linux-kernel+bounces-128252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD0B895857
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54479283D7D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DE3131756;
	Tue,  2 Apr 2024 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9lNGuOb"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7D1E480
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072471; cv=none; b=OLcNCsKgzSljrj632wZrx8ii5R8/5xdrIruSgTWznW4okxo20qsmgnkqZteRGB8p3w6VwxQLI7iFHeDAYZtnbbO3WbI7vgs3crTEc3sSk0YjpiT5PX6ipbXS+x0CmxKxubDlW2IPzIVrwcexhutR2Td/VwwpbvRdc6VGHugSzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072471; c=relaxed/simple;
	bh=TU8EO0MzZSlmEKNek7+eOdrJ3JdtXiHxfEHiqhe8OPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwjCEiYvfavL53/EVIX72uY3kNi6UIZ4+XEVDXhaqh7XlQ0TO0WY8ImWCDRPdNPety+pNojmzZ5mb9hbSUIpTZxiEXi2b5E/QN96Wu7pvEoWofe2/XiQ6YYUoY1Xf5ZHrTbjO/FiaFuCEfVrkweNTLu7jAqo4c1qwI2LUSVd+UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G9lNGuOb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29e0a1fd9a7so3389230a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712072469; x=1712677269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WhSshQF5QQZq0gePIMGOrIKDpDF3rrmi+sIaXmsWik=;
        b=G9lNGuObib1NvYfpxghtVj3lA/cZ0aICjpij2EDC0lbx+NhOb+MJc1y5DLEk/xVZBD
         p4ssJ6kY0cEyWrOHs+89wlj6J53i7n73AJrX+CncxykcOQB7fEtpvRLN07SKgxSzt0Z1
         gNLCyvf5blr1Z7wT+ut3nsusU2pBfmVooRM+E2Mc0HGLvz3xG7AKJPTFnpuSwpDX9U7M
         YG5stwUFR4pzXpi67TrS6qHlNw+orcnMRqy+S9wo+FYuCjisK4bldFEah3aAZcEGs6Fm
         7O7gZgIFiFjYb0hqws8kkr/o/Eu8a8Eb1Y6ct6jVvbt7LPKm6xGTaAnsSab00hkWqi0L
         3jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712072469; x=1712677269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WhSshQF5QQZq0gePIMGOrIKDpDF3rrmi+sIaXmsWik=;
        b=YVwehhG6VHaKmeyz5RdC+6C9hK4kSs0W3cfeRr6o156dJ3MNr7M9iG60GEM4TeVWbW
         IycfwMtLT+QViqww0n9JZlu/AXnoK1/Nz1XHzbWBvafv9LJIxJf+B/KIvuXMFBbwE2rZ
         xVu5FSI9CqjjDedAY/Pjp1KA4/hTEQ4CsL+jqPqA3JFSze5iXtPW/v1Ri4PcdxSn4I/s
         pNIxN5hxW4O3qTUzHWeTWO3sLAA4MLpl0yocaRDqQwk+PfyXL6rqAgTqyVn+PnqFf8ZN
         /Lf9lXOun4aTK+yA9446HD+vUT9Y0yD8yosN11bEWiUU8MUk9DoLkcqROOeUISR2yMIX
         wsXw==
X-Forwarded-Encrypted: i=1; AJvYcCW5NBryIrHLqEWJt/cgBIxVqYIavvO6J0W42L8Yg2B5z5K11fuJ3TX6ZbG6KHXkse9L9KxGNq61RBXLBv5Qq2oYyuw3/T+Tu6EeGETh
X-Gm-Message-State: AOJu0Yz8Kii/U8ukBlJW2vCCm3TKec4xtaLMGnUkhxkrCd6dsqMQpQIM
	1FrWGhehRu6CgD/BKDi2AQEwbQlO0zBUQqAYfOwl9iN4FrmYQttxn2+StDE3LQ==
X-Google-Smtp-Source: AGHT+IGi2934E50vGIGObkktO+KGv+tCJJDLP1EXl8yFe6QMKRg2BG6SQRu/zlkIJnM3nN4Ks/hb7A==
X-Received: by 2002:a17:90b:11d2:b0:2a1:fa5b:106 with SMTP id gv18-20020a17090b11d200b002a1fa5b0106mr19885pjb.30.1712072469226;
        Tue, 02 Apr 2024 08:41:09 -0700 (PDT)
Received: from google.com (139.69.82.34.bc.googleusercontent.com. [34.82.69.139])
        by smtp.gmail.com with ESMTPSA id z17-20020a17090abd9100b002a2723aa39dsm758087pjr.18.2024.04.02.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 08:41:08 -0700 (PDT)
Date: Tue, 2 Apr 2024 15:41:02 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, longman@redhat.com,
	boqun.feng@gmail.com
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, bvanassche@acm.org,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com, xuewen.yan@unisoc.com, hongyu.jin@unisoc.com
Subject: Re: [PATCH V4] lockdep: fix deadlock issue between lockdep and rcu
Message-ID: <ZgwnDnrLJUPyYKYW@google.com>
References: <1707219895-31977-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707219895-31977-1-git-send-email-zhiguo.niu@unisoc.com>

On Tue, Feb 06, 2024 at 07:44:55PM +0800, Zhiguo Niu wrote:
> There is a deadlock scenario between lockdep and rcu when
> rcu nocb feature is enabled, just as following call stack:
> 
>      rcuop/x
> -000|queued_spin_lock_slowpath(lock = 0xFFFFFF817F2A8A80, val = ?)
> -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
> -001|do_raw_spin_lock(lock = 0xFFFFFF817F2A8A80)
> -002|__raw_spin_lock_irqsave(inline)
> -002|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F2A8A80)
> -003|wake_nocb_gp_defer(inline)
> -003|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F30B680)
> -004|__call_rcu_common(inline)
> -004|call_rcu(head = 0xFFFFFFC082EECC28, func = ?)
> -005|call_rcu_zapped(inline)
> -005|free_zapped_rcu(ch = ?)// hold graph lock
> -006|rcu_do_batch(rdp = 0xFFFFFF817F245680)
> -007|nocb_cb_wait(inline)
> -007|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F245680)
> -008|kthread(_create = 0xFFFFFF80803122C0)
> -009|ret_from_fork(asm)
> 
>      rcuop/y
> -000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
> -001|queued_spin_lock()
> -001|lockdep_lock()
> -001|graph_lock() // try to hold graph lock
> -002|lookup_chain_cache_add()
> -002|validate_chain()
> -003|lock_acquire
> -004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
> -005|lock_timer_base(inline)
> -006|mod_timer(inline)
> -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> -006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680)
> -007|__call_rcu_common(inline)
> -007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
> -008|call_rcu_hurry(inline)
> -008|rcu_sync_call(inline)
> -008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
> -009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
> -010|nocb_cb_wait(inline)
> -010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
> -011|kthread(_create = 0xFFFFFF8080363740)
> -012|ret_from_fork(asm)
> 
> rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
> This patch release the graph lock before lockdep call_rcu.
> 
> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
> Cc: <stable@vger.kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Carlos Llamas <cmllamas@google.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---

This patch should be good to go. Maybe it just slipped through the
cracks. Ingo, will you be taking this?

--
Carlos Llamas

