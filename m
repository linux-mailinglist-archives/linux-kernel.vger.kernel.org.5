Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F196775EAF1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGXFju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGXFjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:39:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAF6137;
        Sun, 23 Jul 2023 22:39:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8ad8383faso30660375ad.0;
        Sun, 23 Jul 2023 22:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690177188; x=1690781988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NPdAxJZg6GBQAlUyM1KUW01kgWJyuLebPd0hcpOYbw=;
        b=bo5g0LBXz9ii2g1JNFExFe+tSqtPmu3Rnb+YUc3FUYjpR/GwxL2/eaQ3jMr9g8IU8v
         s5G4EYmx7rFOkGmYHQ6aalOCiqzGhBwMHkfsYp8OaHL0qjYKNYdgapPt353Z9GZ8px63
         LVI4Ysr+zMOAdx+Ct711WKdwodqfsKx4uEA+fFR3lmPuirGFa1JOSk3Uzv/kEJ9CXdjp
         W4r+PyhSEpG9viEB6RnonsuwpS0x3j26svI57dmnDo5fGXYJcQOSdrrJWJZuSZSIK1Hp
         p3BMo/8eG0b0XTlDxNH18UURkLLh14bEyaWNAgnz2dUSCyx+2TCT4U5tp6DOkw+q7ZUJ
         YmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690177188; x=1690781988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NPdAxJZg6GBQAlUyM1KUW01kgWJyuLebPd0hcpOYbw=;
        b=DX97/y1F1507uBKkAshQ/M1ZUs6TDp+xWCRXZIjqL/ASEMaOZFPrXNP+pC+vlcMdzP
         ddD5yjS1C5rukXLXmbRLjBqgZwYuFN+FRkP3JjTOwhkM4K6Lhb9TSy5CkqjnU3KvPMpO
         1wBE1gkFrVxkyf6twwTtej3S+WW5Bhb4TqdFKXiEW+1X9pke3M5b1SFO5X+dimzQUNY7
         IMaDZ94dZbhnWEJSv6q3jmK04okgNZYJa2iV/ZEkmq0VChH9AYDfBaPa2XqB6TRykb3p
         VGHk8dlrXGgO0bzXvjdBgxL4h6uqBdp312tL6c2pvFx10VATg2HS2Oj/16dfqgOh/58Z
         ElNA==
X-Gm-Message-State: ABy/qLbr8Eq6DChqp0T9q76MKcZsbmJiJwm55mBaPBTaPg/EZ1LUJ2kz
        nryQO8/ELWvb7yY1yFuC9oE=
X-Google-Smtp-Source: APBJJlECWNUr0s0tj6ZCkVrDqkSbBw7hvEbN+Xpa7PYEr9d41v6sIlR5WMExeXoIf3yC7r/AOIKirg==
X-Received: by 2002:a17:903:11c5:b0:1b9:ebe9:5f01 with SMTP id q5-20020a17090311c500b001b9ebe95f01mr12760645plh.19.1690177187767;
        Sun, 23 Jul 2023 22:39:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902b20f00b001b7ffca7dbcsm2370035plr.148.2023.07.23.22.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:39:47 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:39:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Input: sh-keysc - convert to use devm_* api
Message-ID: <ZL4OoCV6Nz4Iu/pG@google.com>
References: <20230714080611.81302-1-frank.li@vivo.com>
 <20230714080611.81302-6-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714080611.81302-6-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 04:06:09PM +0800, Yangtao Li wrote:
> Use devm_* api to simplify code, this makes it unnecessary to explicitly
> release resources.

I'd like to see a more complete conversion that results in
sh_keysc_remove() being completely removed.

Thanks.

-- 
Dmitry
