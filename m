Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD37A7A12
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjITLH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjITLHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:07:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27B2F3;
        Wed, 20 Sep 2023 04:07:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so8466799a12.0;
        Wed, 20 Sep 2023 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695208065; x=1695812865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vS/Cs2PLMP0wrXesDar8P/cFTTk09RoR8vpOfuuFr04=;
        b=FXd2I3XyuHZDW6sMuOLbD9oBI6GbFcL07yr+qtB7jwgqvPaOQy9g/DBw8sxq6OpZOe
         XyGCF9GhpjdPlNJUuZMg4KOnHgGEc9NY2+YbXpMZt540ocAogHp0LDTwGli3HnOdAABI
         wAvNRXDSINNzrzZuuiUXVxF0PuF/pENTzexppxjoEvx1P7ql1C4YpJKLRIfP0fYXOt7M
         nC5MP3nbwR4MQ6kvKezFLX3Q7MhwHdzq3qauSFnm+ABMl8SsaRwuUSo/bm6jOERWH8jy
         2k5eUOmMoxVqSSWINbjZOy0+vgNESy9srBjkQtF/h5rr1W06TjFDSfP+QFs+WNc6vd3L
         e0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695208065; x=1695812865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vS/Cs2PLMP0wrXesDar8P/cFTTk09RoR8vpOfuuFr04=;
        b=Ey85zOk9wjcoRLx2jJkLhBZxkytR7etY1z26YXSPVEuxkRl0SB+jdza0syabJ5Jnnf
         qq/EgtCKgn/+ps/0bSmF7YBy3jI7LbSTT8J8LY0NTTLibLgsRY4Pvd3M6EXPnHowB4dE
         WrDBd7RsiGs9KSMTH6DqgfJTGzdciY812beya7dwehUPW4Av2iDTy8qWYl1B+19S1KGT
         1rWbmeV86vQvujJKiRWnk5StpXL/mQjle9Pt4dcCPjcFDvuHaw9E50VllTF93PfKFhIu
         A27ubvqwRfME8ZWBAMOfTCNYaomVIGMA3yTNHez7NcW5h+DGlNGc0LRPzdTQM8XHvF4E
         iKyg==
X-Gm-Message-State: AOJu0YzRICb6kIBU4rjmJi46owZmWeRhSUP9ZzC9/B2ERnMSpWX2saLK
        tVxJYnr7WPd/5MBADkoA3uE=
X-Google-Smtp-Source: AGHT+IHJhYxXGF/oFkiARA6ufQ+RN2C28QZsKxEpzmxPTjndi+q1qWkXBk95MZAnjOn+PYiONQvuSw==
X-Received: by 2002:aa7:d518:0:b0:530:52d2:f656 with SMTP id y24-20020aa7d518000000b0053052d2f656mr1749171edq.21.1695208064972;
        Wed, 20 Sep 2023 04:07:44 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id es19-20020a056402381300b0051e1660a34esm7605111edb.51.2023.09.20.04.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 04:07:44 -0700 (PDT)
Date:   Wed, 20 Sep 2023 14:07:42 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: sja1105: make read-only const arrays
 static
Message-ID: <20230920110742.aykludzienjg5fn6@skbuf>
References: <20230919093606.24446-1-colin.i.king@gmail.com>
 <20230919093606.24446-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919093606.24446-1-colin.i.king@gmail.com>
 <20230919093606.24446-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:36:06AM +0100, Colin Ian King wrote:
> Don't populate read-only const arrays on the stack, instead make them
> static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
