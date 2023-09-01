Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17227901E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350510AbjIASGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350507AbjIASGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:06:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCBCA1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:06:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693591592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/yowoBMKvn6aIMWnEBfAG5rzP0mz/ONo4nTDdYVUg0Y=;
        b=hbHhJa0IhpX2Aq8regx+9cZ/xcgwc07hugTLxiVKqgc+Gj6Xp9w+lIL72RidWRFtLun4Tw
        7Vs30mLclu8F9oMuNGORTh25GSeZiikj2IaYQxPeh4BK0zyG/ZlSdNtt8A2zmpP/DFlxGV
        fqFQeu/1+udCTULgymLnefb19NuUn2DyUjJRiBnJYQRDXm3+HFjHr/p80TxIE/Rl4MVs3Z
        CKr+wJfQORwg5hLH1iqNL+udB6eyhv9XTJVKoucb6Z0Q5FNo9dMcl+gT2fpPG5tURvFfjK
        xx8WA0erVDQgSBEI8UaCzGax1pfsl9vQS5NRh1RAReYN9NvRDJSvlb5wf8nuxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693591592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/yowoBMKvn6aIMWnEBfAG5rzP0mz/ONo4nTDdYVUg0Y=;
        b=FrBe65IGwDVp35cgepdUQ9i0KzlHUU7RGGnnnvVqjJIrfmzGFyl5xOCh9Ng0Sb2UBLgAc6
        xmyGUTNpE4WiwjAw==
To:     Dan Williams <dan.j.williams@intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] configfs-tsm: Introduce a shared ABI for
 attestation reports
In-Reply-To: <64f11081985e_31c2db29440@dwillia2-xfh.jf.intel.com.notmuch>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342400469.3934343.12316161608372095860.stgit@dwillia2-xfh.jf.intel.com>
 <CAAH4kHYNhiewBZ8Z_yF2F+ogkv_1UV8=Gu0KVDdTJN4iQKyNMg@mail.gmail.com>
 <64f11081985e_31c2db29440@dwillia2-xfh.jf.intel.com.notmuch>
Date:   Fri, 01 Sep 2023 20:06:31 +0200
Message-ID: <87cyz14vko.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31 2023 at 15:13, Dan Williams wrote:
> Dionna Amalie Glaze wrote:
>> This is clean and approachable. Thanks for your implementation.
>> 
>> > +static int try_advance_write_generation(struct tsm_report *report)
>> > +{
>> > +       lockdep_assert_held_write(&tsm_rwsem);
>> > +
>> > +       /*
>> > +        * malicious or broken userspace is attempting to wrap read_generation,
>> > +        * stop accepting updates until current report configuration is read.
>> > +        */
>> > +       if (report->write_generation == report->read_generation - 1)
>> > +               return -EBUSY;
>> > +       report->write_generation++;
>> > +       return 0;
>> > +}
>> > +
>> 
>> This took me a while to wrap my head around.
>> The property we want is that when we read outblob, it is the result of
>> the attribute changes since the last read. If we write to an attribute
>> 2^64 times, we could get write_generation to wrap around to equal
>> read_generation without actually reading outblob. So we could end up
>> given a badly cached result when we read outblob? Is that what this is
>> preventing?
>
> Correct. The criticism of kernfs based interfaces like sysfs and
> configfs is that there is no facility to atomically modify a set of
> attributes at once. The expectated mitigation is simply that userspace
> is well behaved. For example, 2 invocations of fdisk can confuse each
> other, so userspace is expected to run them serially and the kernel
> otherwise lets userspace do silly things.
>
> If a tool has any concern that it has exclusive ownership of the
> interface this 'generation' attribute allows for a flow like:
>
> gen=$(cat $report/generation)
> dd if=userdata > $report/inblob
> cat $report/outblob > report
> gen2=$(cat $report/generation)
>
> ...and if $gen2 is not $((gen + 1)) then tooling can detect that the
> "userspace is well behaved" expectation was violated.
>
> Now configs is slightly better in this regard because objects can be
> atomically created. So if 2 threads happen to pick the same name for the
> report object then 'mkdir' will only succeed for one while the other
> gets an EEXIST error. So for containers each can get their own
> submission interface without worrying about other containers.
>
>> I think I would word this to say,
>> 
>> "Malicious or broken userspace has written enough times for
>> read_generation == write_generation by modular arithmetic without an
>> interim read. Stop accepting updates until the current report
>> configuration is read."
>
> That works for me.

That's a pretty theoretical problem. Under the assumption that one
syscall takes 50ns the wraparound on a 64bit variable will take ~29247
years to complete.

I think the important point is that the generation check there ensures
that the expected sequence takes place and can't be overwritten by
accident or malice, no?

Thanks,

        tglx
