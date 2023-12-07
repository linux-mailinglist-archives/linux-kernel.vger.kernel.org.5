Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B3808116
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377810AbjLGGtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377743AbjLGGsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760D010DE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701931728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFOBgtGuzzS/PcpQyRYcdxas2wCmUyPkxn+UwmQBEoo=;
        b=fHe///dgLPTjTfTNpAPaIAQJ8t73AHRlLnxBbKDX6IWOgt08T8Czwu84QkV3vBTk8TaKnv
        OQW2b+OzMj1zMZrBXcnRapBWarSj8uEyOJanFs1mIS7ud331WEhas2jkBqXIcGX0APjBVI
        RNOaMKlexhROyXn1vfXXH1DL3AkSEOU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-6NFsQcm6OEedvXMVjzz_Pg-1; Thu, 07 Dec 2023 01:48:46 -0500
X-MC-Unique: 6NFsQcm6OEedvXMVjzz_Pg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54ca588b6d6so252101a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 22:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701931726; x=1702536526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFOBgtGuzzS/PcpQyRYcdxas2wCmUyPkxn+UwmQBEoo=;
        b=GZl2jDjfvghRYvfmxfV8FakM5K1ih2E9pPsowkrjCp/tniY61m2WTBmd1USz5+v4yC
         JwvWgrJmOXa65PpF2NbvENt6seFq+LkaX3219dfTR4u1ea1NcTGQi0LCOIa43btkU8Xy
         Tcb93PK/+0UUTh0HTMEo3l0beTSXfd+5lraNDLDyGYbn77w2ot6qIEF0v3lHkF3Qxl+8
         f58HO8cl8Ha93H5PspLxBFXyYuIPR3iaLBxGIs8vJXnrG6TpkM1IsyKKizXc/EZSKPSc
         qSo0wymb0UGAtmckdpkovlSrMDSLjeZmzsqOpHhrIHWzY4f5oJD7Xo+6qs6/VmsFrf3b
         Lp6w==
X-Gm-Message-State: AOJu0YxAZCBRrqVMbQMpHYYLOXEFqJMJpJn48Zzqct+KcyDXRYcy59Nw
        x1pEPzxIH6PLv2RtnzaYZnCV2Rv6sNkIwbDQmXtKOJM2d1j/NIkWj2xBL2OdhGkvxH/pNQuqEpP
        en+dfriGVIgCkliPl4X6d/yaO
X-Received: by 2002:a50:f698:0:b0:54b:2af0:dee2 with SMTP id d24-20020a50f698000000b0054b2af0dee2mr1288733edn.4.1701931725885;
        Wed, 06 Dec 2023 22:48:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHP+ojkzLMHbSqAu0C2ANg33CShDwPxZTAJjmCw0nO8Gd6wnGRVjFY+tgfoLKlBErzzBy1nOA==
X-Received: by 2002:a50:f698:0:b0:54b:2af0:dee2 with SMTP id d24-20020a50f698000000b0054b2af0dee2mr1288726edn.4.1701931725570;
        Wed, 06 Dec 2023 22:48:45 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id z61-20020a509e43000000b0054ce0b24cfdsm404552ede.23.2023.12.06.22.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 22:48:44 -0800 (PST)
Date:   Thu, 7 Dec 2023 01:48:40 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tobias Huschle <huschle@linux.ibm.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, jasowang@redhat.com
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231207014626-mutt-send-email-mst@kernel.org>
References: <c7b38bc27cc2c480f0c5383366416455@linux.ibm.com>
 <20231117092318.GJ8262@noisy.programming.kicks-ass.net>
 <ZVdbdSXg4qefTNtg@DESKTOP-2CCOB1S.>
 <20231117123759.GP8262@noisy.programming.kicks-ass.net>
 <46a997c2-5a38-4b60-b589-6073b1fac677@bytedance.com>
 <ZVyt4UU9+XxunIP7@DESKTOP-2CCOB1S.>
 <20231122100016.GO8262@noisy.programming.kicks-ass.net>
 <6564a012.c80a0220.adb78.f0e4SMTPIN_ADDED_BROKEN@mx.google.com>
 <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com>
 <07513.123120701265800278@us-mta-474.us.mimecast.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07513.123120701265800278@us-mta-474.us.mimecast.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 07:22:12AM +0100, Tobias Huschle wrote:
> 3. vhost looping endlessly, waiting for kworker to be scheduled
> 
> I dug a little deeper on what the vhost is doing. I'm not an expert on
> virtio whatsoever, so these are just educated guesses that maybe
> someone can verify/correct. Please bear with me probably messing up 
> the terminology.
> 
> - vhost is looping through available queues.
> - vhost wants to wake up a kworker to process a found queue.
> - kworker does something with that queue and terminates quickly.
> 
> What I found by throwing in some very noisy trace statements was that,
> if the kworker is not woken up, the vhost just keeps looping accross
> all available queues (and seems to repeat itself). So it essentially
> relies on the scheduler to schedule the kworker fast enough. Otherwise
> it will just keep on looping until it is migrated off the CPU.


Normally it takes the buffers off the queue and is done with it.
I am guessing that at the same time guest is running on some other
CPU and keeps adding available buffers?


-- 
MST

