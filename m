Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642D878E373
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344377AbjH3XsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344369AbjH3XsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:48:05 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D532CF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:48:02 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a410316a2so184074b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693439282; x=1694044082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6RCq4RR6/qHE9tOsGvlTBAcbhlgpYNipf9zLQX8qUM=;
        b=INcI6ruN12bwO6BAu59eDJJxeneDqAcGayS6zLWJygScQSa63uK1InzPG1WAtR6v2F
         WmygXpRGQyz8BkSPt47ClYb/53c+JwBB5NG1cieSUoa+LHIk1dyZL5MejcbdVjc7wA8e
         PviuRlMaDjBk0OGFHAVRs6sZyamkRJO/22Qec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693439282; x=1694044082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6RCq4RR6/qHE9tOsGvlTBAcbhlgpYNipf9zLQX8qUM=;
        b=cAmm4uE6HrmvGxY/sBUCfiepJ1f2qLHDtvUpuvGKG+qFD3+kn7NkkoLRYanMczPlgE
         OIYu+iSgt9ZrIAp4fNLbwVDkT4tFM0+ye7gy7jEjuj4jZ3siOf1OJUpTaXciGPz58BMW
         /xgS9XrnI9mYoO73bIqjXmgmZ49Faj7kxseHketYED7xOk4Zp2rntWfiEuBkQBg6qaTx
         GiV8+LaLB+3vaIDxquHSeW4VXoTM3wkCTIjijO+9iJxUQ4Wqh7G72f9VenXfgtuVkVWP
         JpzFpFdLOwPEIcNnfloj7IBhcLEFHXjpVXDBZ2ROQ7FS4bjUdN7Di1MA0dYRqeniHBDP
         zFQA==
X-Gm-Message-State: AOJu0YzSnHME4rc19eFTMge5lshcv/mqVX+gF9u9CiHWfImON53JU/0F
        bngq8CDN5pakN6kd/za2f2yyxQ==
X-Google-Smtp-Source: AGHT+IFanA60iEvBGRDslSUvyeX7/DTo8Q3p/34Deh3Ag4hejUKcEDO69EVdfLaKJXqfQAS0Xc7/xg==
X-Received: by 2002:aa7:88c6:0:b0:68b:a137:3730 with SMTP id k6-20020aa788c6000000b0068ba1373730mr3705724pff.26.1693439282060;
        Wed, 30 Aug 2023 16:48:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q13-20020a62e10d000000b006825003a276sm128202pfh.42.2023.08.30.16.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:48:01 -0700 (PDT)
Date:   Wed, 30 Aug 2023 16:48:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
Message-ID: <202308301646.8397A6A11@keescook>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
 <2023083035-unpadded-amulet-8c7e@gregkh>
 <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
 <202308301421.997C4034B5@keescook>
 <aa488b1d-51b2-7b55-7a8d-552306ca16dd@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa488b1d-51b2-7b55-7a8d-552306ca16dd@foxvalley.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 05:17:12PM -0600, Dan Raymond wrote:
> In my opinion strlcpy() is being used correctly here as a defensive
> precaution.  If the source string is larger than the destination buffer
> it will truncate rather than corrupt kernel memory.  However the
> return value of strlcpy() is being misused.  If truncation occurred
> the copy_to_user() call will corrupt user memory instead.
> 
> I also agree that this is not currently a bug.  It is fragile and it
> could break if someone added a very large string to the table.
> 
> Why not fix this by avoiding the redundant string copy?  How about
> something like this:
> 
> ptr = func_table[kb_func] ? : "";
> len = strlen(ptr);
> 
> if (len >= sizeof(user_kdgkb->kb_string))
> 	return -ENOSPC;
> 
> if (copy_to_user(user_kdgkb->kb_string, ptr, len + 1))
> 	return -EFAULT;

This would work if not for func_buf_lock. The bounce buffer is used to
avoid needing to hold the spin lock across copy_to_user.

-- 
Kees Cook
