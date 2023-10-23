Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C227D3F64
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjJWSih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjJWSid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAB08F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698086265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u4K65KDxcVBXkTfLaNd9e/KXy3N51yIwtDp59/y0wf0=;
        b=NH+G0SIfjp+Ry+KRUWp1nxne7oYLPvI7/07A0E6HylE8QQltQRa8TpYuX7xB9TWgGIXwZ5
        D3VGsrqY0K5AzUaW6Ab1fbhS0fq0wfZV8nMJG091BbmASh3qsiiLtxM1sHLHNo9AmmkEfs
        3rpe/+u1OQBYG6vESoES5B29ePny5jg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-yHI5RgIAOxywxk73A8TWxg-1; Mon, 23 Oct 2023 14:37:28 -0400
X-MC-Unique: yHI5RgIAOxywxk73A8TWxg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-65623d0075aso11526056d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086246; x=1698691046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4K65KDxcVBXkTfLaNd9e/KXy3N51yIwtDp59/y0wf0=;
        b=fQ8BJUSaiyiZ+8lqGlEDrWz5Qk1PRvT5nhxdhxMwGqJ4NzMT8AqXhYD3TFAFJ2vZN1
         jhpNI0xCItWW9DsHZbjQ9Kki7AynRP0kx06zoPzMBiTCrdkeKStIREDRMn9V+1GiFTVq
         +4HS9QGkNkgkvLXyDnGkTtdf/cKGb5dB8JBJQ9K8FLBEvUXfqF1KkWqzHZiisy8U5UQY
         nFZ1BzQYrrsNop0eQfXZo4VmCXHfbm5V841AhO5ybUiiklkqyOrLsqsBlgNg5UOHYFeC
         oUXX/MGzoOlO6WRDnEX9mw1eQMJdslzJJkxJOfaUh2Gn53UXuYOio02+QHdcdiwH/Fi/
         lx7w==
X-Gm-Message-State: AOJu0Yw8UQ/2ixVnied/AysMW70jgoFYFM7zOSBzVBFtqagbepKm3six
        7qO5M70wDsOxHZKINOPC3AhUxoWaDhdqLBAmkFdVpXJN1D3OjjdiXdivhCuRyXxQ1DaaRts85we
        ptiRnGnTqTzYd03aT7HKvGdwX
X-Received: by 2002:ad4:57d1:0:b0:66d:b23:a62e with SMTP id y17-20020ad457d1000000b0066d0b23a62emr10149580qvx.6.1698086246657;
        Mon, 23 Oct 2023 11:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSC2tyow+6AySdZJ7+gMEaJlJb2QTPUAC5dumXqlwlIN8V3DCe/xX12BrSeeNMm9RA8GJlvA==
X-Received: by 2002:ad4:57d1:0:b0:66d:b23:a62e with SMTP id y17-20020ad457d1000000b0066d0b23a62emr10149543qvx.6.1698086246299;
        Mon, 23 Oct 2023 11:37:26 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id cr14-20020ad456ee000000b0065aff6b49afsm3058368qvb.110.2023.10.23.11.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:37:25 -0700 (PDT)
Date:   Mon, 23 Oct 2023 14:37:23 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <ZTa9Y++/PCV7HRoM@x1n>
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
 <ZShsQzKvQDZW+rRM@x1n>
 <CAJuCfpEtaLs=nQK=oPHe9Nyq1UoqLk1pt2k-5ddDks3Ni2d+cw@mail.gmail.com>
 <ZTVVhkq8uNoQUlQx@x1n>
 <CAJuCfpEDEXHVNYRaPsD3GVbcbZ-NuH0n3Cz-V0MDMhiJG_Esrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpEDEXHVNYRaPsD3GVbcbZ-NuH0n3Cz-V0MDMhiJG_Esrg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:43:49AM -0700, Suren Baghdasaryan wrote:
> > Maybe we should follow what it does with mremap()?  Then your current code
> > is fine.  Maybe that's the better start.
> 
> I think that was the original intention, basically treating remapping
> as a write operation. Maybe I should add a comment here to make it
> more clear?

Please avoid mention "emulate as a write" - this is not a write, e.g., we
move a swap entry over without faulting in the page.  We also keep the page
states, e.g. on hotness.  A write will change all of that.

Now rethinking with the recently merged WP_ASYNC: we ignore uffd-wp, which
means dirty from uffd-wp async tracking POV, that matches with soft-dirty
always set.  Looks all good.

Perhaps something like "Follow mremap() behavior; ignore uffd-wp for now"
should work?

-- 
Peter Xu

