Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342E9765C05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjG0TVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjG0TVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:21:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A866D30E1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:21:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98377c5d53eso177577166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690485689; x=1691090489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CMVC/xmQcqwSqBzvS5kpbfVcWFfNCx3gJcsonstxVoQ=;
        b=A90XbHPWVeV6ghMsF2q3ncxcXaG/9F56P6HcqI/Qc6wPkx7ys5i+ppXuMh+S3v6g2p
         AuUtBqL86j4orXonaQORIl8O/oia1zyjBFmupqLjvubhp3tvZp/8F8z05xSnOcznw1a3
         qz+fC2w1NGBqPa1pRFFjr9K3HhEpkKiUh9Rfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485689; x=1691090489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMVC/xmQcqwSqBzvS5kpbfVcWFfNCx3gJcsonstxVoQ=;
        b=UzGUcJ3M+iybxFZv7gDz6ka/I4+z8BpbK+hQL/UL/vMwQJeyQTJAsrFfTCq0OJ3RqI
         5vmWo0i4S4QiVmGnu35cc3fxK50xbWjDJesGa1bpssdo2s0zOEmkwr8CVd1gI5xaqYyl
         pYKTMpJp4+aw7i/U6yjtJxqVMx7H+NieFCvTuNQicqKR8V51zWGap7xw3FO+ud/vd2k6
         a6xa+JjQ7Ww6rETLm8Ul4ZoNyt/rOuid6LSIIMG78uodhvgW9yNfYmeWoGjM4USaelOZ
         S1w4XL+D2C/aSyzqrqLHTxWjnh35xQpEsqxtAQylTOjK7Q5FcOKkB4aLEpa/McvzZ+TO
         SAjQ==
X-Gm-Message-State: ABy/qLbrnSrZgVctFUVsoneNeRPLOGfYS0Iq/fJA6ZstUkBTB26HdHF2
        06b6Ytp+ZYlwyVYiGdbMHaSX1+iZJQK/6cXd6u+5cA==
X-Google-Smtp-Source: APBJJlF2t+YKOnZMzjcVO2vmlHXHDn+Vc4n5sCS24LMePL4Tq12fixTzHpGRBzcPfVixgZXxQiU3Co38OQxE/Vxuhk0=
X-Received: by 2002:a17:906:328b:b0:982:45ca:ac06 with SMTP id
 11-20020a170906328b00b0098245caac06mr110008ejw.60.1690485689143; Thu, 27 Jul
 2023 12:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230726105953.843-1-jaco@uls.co.za> <b5255112-922f-b965-398e-38b9f5fb4892@fastmail.fm>
 <7d762c95-e4ca-d612-f70f-64789d4624cf@uls.co.za> <0731f4b9-cd4e-2cb3-43ba-c74d238b824f@fastmail.fm>
 <831e5a03-7126-3d45-2137-49c1a25769df@spawn.link> <27875beb-bd1c-0087-ac4c-420a9d92a5a9@uls.co.za>
In-Reply-To: <27875beb-bd1c-0087-ac4c-420a9d92a5a9@uls.co.za>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 27 Jul 2023 21:21:18 +0200
Message-ID: <CAJfpegtaxHu2RCqStSFyGzEUrQx-cpuQaCCxiB-F6YmBEvNiJw@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir.
To:     Jaco Kroon <jaco@uls.co.za>
Cc:     Antonio SJ Musumeci <trapexit@spawn.link>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 20:40, Jaco Kroon <jaco@uls.co.za> wrote:

> Will look into FUSE_INIT.  The FUSE_INIT as I understand from what I've
> read has some expansion constraints or the structure is somehow
> negotiated.  Older clients in other words that's not aware of the option
> will follow some default.  For backwards compatibility that default
> should probably be 1 page.  For performance reasons it makes sense that
> this limit be larger.

Yes, might need this for backward compatibility.  But perhaps a
feature flag is enough and the readdir buf can be limited to
fc->max_read.

Thanks,
Miklos
