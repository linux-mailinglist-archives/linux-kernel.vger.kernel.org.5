Return-Path: <linux-kernel+bounces-23818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384FF82B229
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB7228B0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BB94F894;
	Thu, 11 Jan 2024 15:52:24 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4C4F882
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40BExr1v003615;
	Thu, 11 Jan 2024 23:59:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Thu, 11 Jan 2024 23:59:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40BExr5b003610
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 11 Jan 2024 23:59:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b1adbb1c-62b7-459f-a1bb-63774895fbb3@I-love.SAKURA.ne.jp>
Date: Thu, 11 Jan 2024 23:59:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [kasan] a414d4286f:
 INFO:trying_to_register_non-static_key
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com
References: <202401111558.1374ae6f-oliver.sang@intel.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202401111558.1374ae6f-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit a414d4286f34 ("kasan: handle concurrent kasan_record_aux_stack calls")
calls raw_spin_lock_init(&alloc_meta->aux_lock) after __memset() in
kasan_init_object_meta(), but does not call raw_spin_lock_init() after __memset()
in release_alloc_meta(), resulting in lock map information being zeroed out?

We should not zero out the whole sizeof(struct kasan_alloc_meta) bytes from
release_alloc_meta() in order not to undo raw_spin_lock_init() from
kasan_init_object_meta() ?

On 2024/01/11 16:29, kernel test robot wrote:
> [    1.582812][    T0] INFO: trying to register non-static key.
> [    1.583305][    T0] The code is fine but needs lockdep annotation, or maybe
> [    1.583887][    T0] you didn't initialize this object before use?
> [    1.584409][    T0] turning off the locking correctness validator.


