Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1373A7A2889
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbjIOUs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237674AbjIOUso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:48:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BE22709
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:48:25 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fb7fb537dso2440247b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694810905; x=1695415705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+PPJ/AQSOJ+ikTUxwaFbNmWB98quGmGcGYVc1MYqo4=;
        b=jPZozsT2o/pJmTgFxnggifmMGrjbs5MuLtv7waWc89P3K+bPqQH/p7vjLcadQK+MU7
         vxqjrmlBtCmHuw90Q82F0o8yao4Yn3GWTgAs2C31YgChWxjAAUiBiSoMPRoyTcy8lc6m
         pFCe+p5RaVU7seSH2iTU7EpjQcaH9h4zhxzr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694810905; x=1695415705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+PPJ/AQSOJ+ikTUxwaFbNmWB98quGmGcGYVc1MYqo4=;
        b=rf0FBonrKBol/DKKUTrfs8qnsUmxhP0VnFpGqMfiicvm/R0qiOA5ImpuuNLWcdQqpR
         6sZp2sONmh0U5JC1aOt95QhrDO0M8IcpicT26cTFHRFDZ5UJjtUKptTP89aAovZiBCEe
         S6kcQhsfjgsJS+9PSaxsPDTVyAAVgkKQOL8Nb6hjtCj5/lwHdWiPU/2uUvdHcmSKMyEn
         KkvwQtbskN1b8fRJgvHCJIx0Iic7KyxgqiNFyxrtdIhVzyvZJ6bkJy3rjCqRmrp8Eqc7
         5xuXx2cy4pMlGY/qGWc9zxGIUg8ZZFnqZp6Zk5t/RD5FGUjfXYi+2P6oR7IVMdogPI8C
         p5Ew==
X-Gm-Message-State: AOJu0YzPv81EOfJow0VY1z7zWUtBE5MBnTwyoayClhESqOVxRaBY+vFK
        z2/yslcovLmgkT6EGEz7ImExX7jT4hL/3DYYc3c=
X-Google-Smtp-Source: AGHT+IFOxKRcwk4qHKzzxE6vlTeEqFbIORzQ9ufHcf3GvQ/kLYWfVDwqBjcVYUd19W39PY4imGNNKA==
X-Received: by 2002:a05:6a00:2d0b:b0:68f:ca4a:efd with SMTP id fa11-20020a056a002d0b00b0068fca4a0efdmr3093829pfb.9.1694810904753;
        Fri, 15 Sep 2023 13:48:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b0069026841829sm3319396pfo.113.2023.09.15.13.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:48:24 -0700 (PDT)
Date:   Fri, 15 Sep 2023 13:48:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Rheinsberg <david@readahead.eu>
Cc:     Justin Stitt <justinstitt@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: uhid: refactor deprecated strncpy
Message-ID: <202309151342.DFA6CA5C7@keescook>
References: <20230914-strncpy-drivers-hid-uhid-c-v1-1-18a190060d8d@google.com>
 <202309142206.60836CE@keescook>
 <98d981a1-4e4c-4173-b8eb-09b4245bca60@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d981a1-4e4c-4173-b8eb-09b4245bca60@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:36:23AM +0200, David Rheinsberg wrote:
> Hi
> 
> On Fri, Sep 15, 2023, at 7:13 AM, Kees Cook wrote:
> >> -	/* @hid is zero-initialized, strncpy() is correct, strlcpy() not */
> >> -	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
> >> -	strncpy(hid->name, ev->u.create2.name, len);
> >> -	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
> >> -	strncpy(hid->phys, ev->u.create2.phys, len);
> >> -	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
> >> -	strncpy(hid->uniq, ev->u.create2.uniq, len);
> >
> > ev->u.create2 is:
> > struct uhid_create2_req {
> >         __u8 name[128];
> >         __u8 phys[64];
> >         __u8 uniq[64];
> > 	...
> >
> > hid is:
> > struct hid_device { /* device report descriptor */
> > 	...
> >         char name[128]; /* Device name */
> >         char phys[64]; /* Device physical location */
> >         char uniq[64]; /* Device unique identifier (serial #) */
> >
> > So these "min" calls are redundant -- it wants to copy at most 1 less so
> > it can be %NUL terminated. Which is what strscpy() already does. And
> > source and dest are the same size, so we can't over-read source if it
> > weren't terminated (since strscpy won't overread like strlcpy).
> 
> I *really* think we should keep the `min` calls. The compiler
> should already optimize them away, as both arguments are compile-time
> constants. There is no inherent reason why source and target are equal in
> size. Yes, it is unlikely to change, but I don't understand why we would
> want to implicitly rely on it, rather than make the compiler verify it for
> us. And `struct hid_device` is very much allowed to change in the future.
> 
> As an alternative, you can use BUILD_BUG_ON() and verify both are equal in length.

If we can't depend on ev->u.create2.name/phys/uniq being %NUL-terminated,
we've already done the "min" calculations, and we've already got the
dest zeroed, then I suspect the thing to do is just use memcpy instead
of strncpy (or strscpy).

-- 
Kees Cook
