Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1869578B783
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjH1Sq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjH1SqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:46:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C8FCF6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:45:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a41031768so2478791b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693248344; x=1693853144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5qslD60JD6KLOV4CQIfjlboyQ+Y8tlju0WfnPmgJqI=;
        b=PtVDUpnaFkIsNT/B082DAe0srHqs05yHezYhN4SbovBY9s95E5Lvqy6jKZB75q7+/p
         FT5wV/0ifBG4UkwZaCRXqGppgqbyOaKn63hkGY4zein/yMJDNeCM88TntuHNV2ns4pFT
         gKAyj40UiujO2i4v+INYGzXuH12Cpo4p1w/eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248344; x=1693853144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5qslD60JD6KLOV4CQIfjlboyQ+Y8tlju0WfnPmgJqI=;
        b=aPF24G5fmn7GY8TiJFBjX9GDalYaWGAJlR5Va7Id/QH/7VjxtA0Ecm4inlt2EyWy3E
         0PWakuMRmZau0N+5P6IFDuIlmmTnIdxENF6pC6VVEr6Rlo8EYDs90Oa5iebcqz/RP4ex
         U/tP4DFjiciznkbBlMTC/3BKRoyspIulwcfg8Ku79awk3++90Ip8C+K9WA2lzLthBs+g
         LqsvveYTCW5LL/WVGhg5D4XyCYysIET17RY8PoBP/h4HG3C7rqbHuTTpl1OBIl/rJ5qZ
         jZYKBkB5+v7pwYWsn9NqcY//YVaGS1e/9dopYCoqBG0BQ0MWvWj8cn2rfRZnXvL6UdKm
         H71w==
X-Gm-Message-State: AOJu0YxaSjHCWydp3MqtRAIYfft9NDdFaIBGGokaYU50UmnOQdEducSF
        wXYw/9mHaGP/RRlkDzfncu90whpYSC22CL7UKhw=
X-Google-Smtp-Source: AGHT+IHvRKHA/GEAGdRc0GFMALbV74qompHMrn9Pd4DMWxpSSTAYLhaSNqnHVHthOf+gQ/mKOYR/5Q==
X-Received: by 2002:a05:6a20:c901:b0:149:812c:76f with SMTP id gx1-20020a056a20c90100b00149812c076fmr15416452pzb.47.1693248343927;
        Mon, 28 Aug 2023 11:45:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j5-20020aa783c5000000b0066684d8115bsm7219213pfn.178.2023.08.28.11.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:45:43 -0700 (PDT)
Date:   Mon, 28 Aug 2023 11:45:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com, ayush.jain3@amd.com
Subject: Re: [PATCH v4 6/6] kselftest: vm: Add tests for no-inherit
 memory-deny-write-execute
Message-ID: <202308281145.4006BC6@keescook>
References: <20230828150858.393570-1-revest@chromium.org>
 <20230828150858.393570-7-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828150858.393570-7-revest@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:08:58PM +0200, Florent Revest wrote:
> Add some tests to cover the new PR_MDWE_NO_INHERIT flag of the
> PR_SET_MDWE prctl.
> 
> Check that:
> - it can't be set without PR_SET_MDWE
> - MDWE flags can't be unset
> - when set, PR_SET_MDWE doesn't propagate to children
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Florent Revest <revest@chromium.org>

Looks good!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
