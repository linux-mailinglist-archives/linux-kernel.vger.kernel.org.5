Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092167E4850
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjKGSd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjKGSdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:33:51 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2CD13A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:33:49 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-777719639adso386214485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1699382028; x=1699986828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8avTRAw+qJM+8GGepFLeKQe8V+ZhPn3lvGUNQHQn6cU=;
        b=yIUeXeYCR8+IvzqbBHzgNiZxjiwRGDDP+qr3mSKG6xMPnrqk9cN9BeOSHjCI03BFUq
         v572k2Nwks11alnC9xIWvOTeHqvH4VHiJ22Ysny8mDZP832kbE5COa6YX1r9D7tl13fl
         jp8QAHnhswRo8ofdCVwDHnfKaW0ETmbRQnaH3PjzA+Sek1cATn5gLgKwg6g4l0aIqiu+
         42IAd/Ld+bzj2it0TS/lUTtyhWEy1ofuUhpCWKezOD0YJhQ6dYhOqWHzgypgGV3imnG8
         6ktUJCrgZrWeqYmpBJbep3jaf85gq26FfEM0CiJ8V8cmgNK4Jm8A5z+R+U7uEe0/3eJ7
         LdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699382028; x=1699986828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8avTRAw+qJM+8GGepFLeKQe8V+ZhPn3lvGUNQHQn6cU=;
        b=BbksefGdhePX3XQcwwp8mMfng8g25u+4ema4eJea5Ftgz6DUK5MLqtP1kzRZM0cLY6
         Em0mQOq5SLTRbmNXXoH0XF7QP+hvh6vWX/fGFJf9ameWSnZOnd7+eY+h+y4xP/LHSM6u
         bbL0fKzgWsxOJoUE2pn8aEtrvWNfbWQsf7bNWsUp//gTjTHLSo4STgrp83BgLVz8iBCx
         H4ojkOeyak3gJkdyTJNI8sAzjxo2o36QG7PoW5Pybm/KY/smmEdYC+nOxP7SA+owMUCm
         qf7jmD8HIriWoMyB5faqO/gWL4rWQA2i+ep0Am2wVynBvSiyGgmCINra1y3kobhILlCI
         Qpag==
X-Gm-Message-State: AOJu0YyThI/zvyL2gNjwg1fyuNz2c44rDK6/Gbe2Hb39ptW6oWYFmekN
        /kjq5sg5bEMAEavKlA2hfcGwGQ==
X-Google-Smtp-Source: AGHT+IH01xrkUfmAz5hEXZhH23UNWoyA7VRhKDTDM4x2eoKe8MdyAO1UMYAPhWv6pWRLzrBzISOJbQ==
X-Received: by 2002:a05:6214:f04:b0:66d:9d28:3686 with SMTP id gw4-20020a0562140f0400b0066d9d283686mr41129341qvb.53.1699382028083;
        Tue, 07 Nov 2023 10:33:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:86b7])
        by smtp.gmail.com with ESMTPSA id j2-20020a056214022200b00670f8570a24sm157124qvt.23.2023.11.07.10.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:33:47 -0800 (PST)
Date:   Tue, 7 Nov 2023 13:33:46 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hyeongtak Ji <hyeongtak.ji@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: Re: [PATCH] mm/vmscan: consider previously reclaimed pages in
 shrink_lruvec()
Message-ID: <20231107183346.GA3789583@cmpxchg.org>
References: <1691402476-4838-1-git-send-email-hyeongtak.ji@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1691402476-4838-1-git-send-email-hyeongtak.ji@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:01:16PM +0900, Hyeongtak Ji wrote:
> shrink_lruvec() currently ignores previously reclaimed pages in
> scan_control->nr_reclaimed.  This can lead shrink_lruvec() to reclaiming
> more pages than expected.
> 
> This patch fixes shrink_lruvec() to take into account the previously
> reclaimed pages.

Do you run into real world issues from this? The code has been like
this for at least a decade.

It's an intentional choice to ensure fairness across all visited
cgroups. sc->nr_to_reclaim is 32 pages or less - it's only to guard
against extreme overreclaim. But we want to make sure we reclaim a bit
from all cgroups, rather than always hit the first one and then bail.
