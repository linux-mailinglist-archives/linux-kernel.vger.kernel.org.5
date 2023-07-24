Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEBF75EAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjGXFeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXFef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:34:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5FC109;
        Sun, 23 Jul 2023 22:34:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666ed230c81so3809699b3a.0;
        Sun, 23 Jul 2023 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176874; x=1690781674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aakJoR5SDfOC3XF2g11SRCYc6/sCovHC8GmGvDOFBq0=;
        b=Pyb144HncaoUm/nOFYkqYSi5VnckYQj0tAHbI+QRkYSzK3j+nvx7sDtdHHmhVL/csx
         QI0RAwqdyy+8JocVYb9xa26GztSsazm84IV6CtavEnHbqDwZcS5bzSs93mVQ0VO45DCY
         JnYwyrcF6/JPtZOjPNNUGUZaWfpi3hlzSBkVCBTzaWU0NiNIoxKex20+mCW2ZO08Aruv
         /w0KtA29pJVRZPD+WJqYA1wmCYv3AX/boCoOVvngHcOSsysJ2idqO84P9Fb4hPgDHqRi
         pUE3ahXtx7PQyV3vT0FU7ci3y4IuHVMfFoOsuz41mCWFmzAOfQyFpWY9b4fzCBPprDqx
         K8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176874; x=1690781674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aakJoR5SDfOC3XF2g11SRCYc6/sCovHC8GmGvDOFBq0=;
        b=SGIFgDJnLTwLvRATgzHW4o+rdVo7EAKtf9Apdf/5dWt4645JJ0qpfSI8jslL9KrhMV
         1LbbEGITEPaV3eXamySJkDGYph1DOjMZ5B7m5MkP1ihm+GdyhYaXQnNY5C8YoeUZJ4+k
         gLZwhgCjqaenhyIAgGiQz57V9BvSzxbMOOBuzuhZHtoPU4uS2i+xsE0xwhjbIAi+czom
         MO59pH7AQYD04NSrlJbkxbIx30d8/dv3R+4+QqrnxNDNXCKrTCv1TNeoctK2oji5wspg
         LBcK8DHuHJYFjibaALVrckQ0L7OgeC/32Cx+nfpdkXvWksdmiKDihgkShVcWQ31/KsgB
         FLXQ==
X-Gm-Message-State: ABy/qLaXipyFFtxIZ2xxF+1xXYcOk41eu4qgXRKWOwwUASpVzWC2KX02
        JLat41sdL6W3hh/TO8wE/rmR3UX+aeM=
X-Google-Smtp-Source: APBJJlFDmq7JU2ZovR8eEOaUD9difSsyL4zsINomddw+xDjqKxPKsBRF00duMLr6B0uAbuPyRxarLA==
X-Received: by 2002:aa7:8882:0:b0:682:57f0:7c0e with SMTP id z2-20020aa78882000000b0068257f07c0emr11039488pfe.11.1690176874106;
        Sun, 23 Jul 2023 22:34:34 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id y8-20020a62b508000000b00663b712bfbdsm6751869pfe.57.2023.07.23.22.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:34:33 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:34:31 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] Input: mcs-touchkey - convert to use devm_* api
Message-ID: <ZL4NZytgXv9RXU5T@google.com>
References: <20230714080611.81302-1-frank.li@vivo.com>
 <20230714080611.81302-3-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714080611.81302-3-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 04:06:06PM +0800, Yangtao Li wrote:
> Use devm_* api to simplify code, this makes it unnecessary to explicitly
> release resources.

Applied with minor edits, thank you.

-- 
Dmitry
