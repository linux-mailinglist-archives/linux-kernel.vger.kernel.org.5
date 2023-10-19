Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927EB7CEEAA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjJSEdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjJSEdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:33:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E974A121
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:33:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so4472668b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697689992; x=1698294792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTvrXbcdzsD7YSLg36ffe2oHA15KfNm4vV4kTMiGL9E=;
        b=HvfZTfjh6TZRdbjonPLOqTZcBSXQRlzeYm0iyjBH6rTsNZhQ/bz7V3WrvvMN15mHk9
         D2PrJpk+nVJl5T63akZpeaJddPGxEafzyUV1N10riox08O9gqfkxeoOMisZ+BkT5w0NJ
         BLEl5CKQd8HesBI8A8UDDyuxVkCTpCIdvY+p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697689992; x=1698294792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTvrXbcdzsD7YSLg36ffe2oHA15KfNm4vV4kTMiGL9E=;
        b=ZYzFjARMICLcb73SrxteM3yvO29l8bwN9CPhzuIXkjmUiLWUtppl6BIbk3KH/iSNK6
         +eF749yXMDTHc+wupLyxjEdc8TtXPBBGEIzAe0et+frM2buoFQgginCIQZYvoUhaswPY
         e7sGlrH9gz6h22H8ktqZbR/JcVh4lyKxt3z+S2n9DabzF4fqZpNhh01P8RbxaGJBC7Ch
         V9E+3UifJ6tkCRGbOv5GVc9gdDCgjkF12NUaX6oz73Uc6L+E9cjhNpk6zX7NWijBUBb9
         otMYknBClcOF4AEIRTYK3Q0UO8sF15plAumm6A+/EUXygLG2q2XwdZsZsVn36zT9q5Va
         O1OA==
X-Gm-Message-State: AOJu0YxGnFAqHlLLt5C4+roytQMoC9lzXKtwqvDNK0tRu+EDniUDrv3P
        o92thrbfWW7LgObYbAlNYNuV7w==
X-Google-Smtp-Source: AGHT+IEsnYPHdzEqfSrZlO8TbPOIQg1bWrdfxEfkBVjsJXXB9B7SRMVs52VWeTNlIlF0Gmj5M1z7iA==
X-Received: by 2002:a05:6a20:9155:b0:133:f0b9:856d with SMTP id x21-20020a056a20915500b00133f0b9856dmr1215010pzc.17.1697689992452;
        Wed, 18 Oct 2023 21:33:12 -0700 (PDT)
Received: from google.com (KD124209175111.ppp-bb.dion.ne.jp. [124.209.175.111])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b0027df6ff00eesm509871pjb.19.2023.10.18.21.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 21:33:12 -0700 (PDT)
Date:   Thu, 19 Oct 2023 13:33:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] mm: hugetlb: Only prep and add allocated folios for
 non-gigantic pages
Message-ID: <20231019043305.GB14965@google.com>
References: <20231009145605.2150897-1-usama.arif@bytedance.com>
 <20231010012345.GA108129@monkey>
 <20231012000327.GA1855399@dev-arch.thelio-3990X>
 <20231012145318.GA5127@monkey>
 <20231013001203.GA3812@monkey>
 <20231014000450.GA253713@monkey>
 <CAKwvOdm9xKGQzi6_j=gGZCEmKJe6b9o8+jen1oEeAhyjcaSnxQ@mail.gmail.com>
 <20231018222003.GA21776@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018222003.GA21776@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/10/18 15:20), Mike Kravetz wrote:
> > I think you need to initialize h, otherwise what value is passed to
> > prep_and_add_bootmem_folios if the loop is not run because the list is
> > empty.  The compiler sees `h` is only given a value in the loop, so
> > the loop must be run.  That's obviously hazardous, but the compiler
> > assumes there's no UB. At least that's my limited understanding
> > looking at the IR diff Nathan got me in
> > https://github.com/ClangBuiltLinux/linux/issues/1946.
> 
> Thanks for looking closer at this Nick and Nathan!
> 
> I think you are saying the compiler is running the loop because it wants
> to initialize h before passing the value to another function.  It does
> this even if the explicit loop entry condition is false.  Is that correct?

The loop is getting promoted to "infinite" loop, there is no
&pos->member != (head) condition check in the generated code
at all (at least on my machine).

I wish we could at least get the "possibly uninitialized variable"
warning from the compiler in this case, which we'd translate to
"hold my beer, I'm going to try one thing".
