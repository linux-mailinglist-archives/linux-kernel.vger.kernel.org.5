Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22816801290
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379234AbjLASYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379172AbjLASYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:24:48 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FD59A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:24:54 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ce3084c2d1so7400515ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701455094; x=1702059894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XGfXIS6HVXe6/e9l+81iwua90KgKcNdbupUOWB7Nz4=;
        b=TdPdaFZZ3WviX3IKVUi4jbog10SuoD+yCPANUZKGvaaShxGJwBbme9EtbtTmynM59y
         UFJfAYfnXr+N+oGV/aZIyHaI09G6n242oOl7SQs1Elm0pHOtU1GsfAlR0T/fCkjFoTWn
         AZwww81WmkWbCcHy6EuK4/yFZBOieZW47fpmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455094; x=1702059894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XGfXIS6HVXe6/e9l+81iwua90KgKcNdbupUOWB7Nz4=;
        b=RJ3btY2prhyne/uuH7A89D0ezf/O9CjV2HK4WmwPFkhYNFwFOtooO/nF7QiL73Helf
         OCsZK34C55Q5sQOkHrXhMYIX+SegLm678KtbnvV6mbkyhl5OL2gSGxDHk1wIUyU1Tqqq
         jdIOuY6qjhGA+8okJ4cFejrwBm0ldegnWuigOr92Z0R45LoPQVCV7Pia6L+F/B9C8fIb
         AL5G2YPisVBijdDTAz/YU6/DKX+R1jdfEkkwKYeTzdePC+DAHOutAx+QOqnTKSEu+Cka
         IsSiRw+oLMxt/0JXmnp6NKYyYRLFQMjXbo229/zDpnfvMF/uzg3Wp4mkVXxxe2nwia/G
         dyog==
X-Gm-Message-State: AOJu0YxOwFcvbMY3wW8si4PIMAulbB+rlyMSAd9tA9TU/1tXhYuGwD1+
        vOnBF0Dmzlr8vd0yRq4Ek9XMf5lBCfJGemgHGc8=
X-Google-Smtp-Source: AGHT+IEKh1U4LPfxGBUf3mJlHka+NhvaJ2NeciUnM51C148o06P3qKGJSwZ6cx5VsvdxmcRwKotuZA==
X-Received: by 2002:a17:902:8e8c:b0:1cc:6cc3:d9eb with SMTP id bg12-20020a1709028e8c00b001cc6cc3d9ebmr24187576plb.68.1701455094201;
        Fri, 01 Dec 2023 10:24:54 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001cf7bd9ade5sm344223plw.3.2023.12.01.10.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:24:53 -0800 (PST)
Date:   Fri, 1 Dec 2023 10:24:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tracing/uprobe: Replace strlcpy() with strscpy()
Message-ID: <202312011024.8FD7DD329F@keescook>
References: <20231130205607.work.463-kees@kernel.org>
 <20231201152726.91421003ccd64eb5e369043c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201152726.91421003ccd64eb5e369043c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:27:26PM +0900, Masami Hiramatsu wrote:
> On Thu, 30 Nov 2023 12:56:08 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > strlcpy() reads the entire source buffer first. This read may exceed
> > the destination size limit. This is both inefficient and can lead
> > to linear read overflows if a source string is not NUL-terminated[1].
> > Additionally, it returns the size of the source string, not the
> > resulting size of the destination string. In an effort to remove strlcpy()
> > completely[2], replace strlcpy() here with strscpy().
> > 
> > The negative return value is already handled by this code so no new
> > handling is needed here.
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
> > Link: https://github.com/KSPP/linux/issues/89 [2]
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: linux-trace-kernel@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Hi Kees,
> 
> As same as sample's change, should I ask you to pick this to your tree?
> Since it is a kind of a part of series patch. I'm OK for it since this
> does not change the code so much.
> 
> In that case, please feel free to add my Ack.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Either way is fine, but I can take it since I've got a few others
already too. :)

Thanks!

-Kees

-- 
Kees Cook
