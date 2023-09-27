Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AC57B071E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjI0Ojm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjI0Ojk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:39:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7137AF3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:39:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40535597f01so113172765e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695825577; x=1696430377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/d0O6KoBBcVDhiAyK6/22CPBVqgPOAgVU0f7WwKl+90=;
        b=X0yInaTTVG84VNJbWXWeUZk/KiDNOJA1im6tD5SHhz9gIG8Jc9rWz5jjBs3sXQSRQT
         e/2hKDFfDBl5uXYsMgojwhJNumNJCtcXQNoGbJXbGxqmbcz061mMkiYQb8dcrf5B41mu
         Fnacv0T7/7SMErTRk7bTuLytCRQRoldRO7TovNCRi+G7wj0vNMom3Hrsn8ipejwV42Af
         n8dVmqmdJ+i51A9pRXVGJxLnl+hkF6KlTZETaD0NsFYc4Zgf/Vp3ZJv6pvDbqvz0RISc
         ylSGeNAkRaXB0qi2+qBtUI87JyKUWGyHvvu5nesp/0Q9GQkPtn3KIYz1Q21+6AmRJc9k
         5q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695825577; x=1696430377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/d0O6KoBBcVDhiAyK6/22CPBVqgPOAgVU0f7WwKl+90=;
        b=OoGWmqhuDT1Nfrkl+ST9uoiviAjUsB0HLrC9eL9knxNiE4cW9kLPaVqeBPxCGZQt+J
         zx/puivfOH0+Gvu832XM42jQb8tLPzzBHft+Si7mMYW0Omg77g6Tm8KHl60mcDyGDqVG
         P1dLzau7AmuzROscoStVg3D9HbFe3B7DgHrvnpFdgQ+Dxz6sHZlNgCq45JfV7mCdton7
         mZZ6DCISjKNebvwEq7HrgxlbQMPVrC7ckvrZ7Soo+fwubu3Ox50TSlNmgjpDeYK0PuY9
         0uJNVEJJav1DlMEv9bvr4O4r/ozGlLaWLfdE28LDCLRtBI2vdFAHfi53S/IXIzlGCeWe
         EOcg==
X-Gm-Message-State: AOJu0YyRuW6m4er0srzVa0Gf/bHC3rTJJmij12Tqb+sRDMldhIjT9LLl
        nAZjnywbDfSxWNX5LclkiMwAj9ItHocIuUL2AK8=
X-Google-Smtp-Source: AGHT+IFvNEZDv5Y5OceM93YwR6RkX3JyiUbg2tuwwbpQakpWx4Px8t9lxkMzS5zdwGox0O4uB7W8nA==
X-Received: by 2002:a5d:66c4:0:b0:31f:84a3:d188 with SMTP id k4-20020a5d66c4000000b0031f84a3d188mr1890900wrw.22.1695825576817;
        Wed, 27 Sep 2023 07:39:36 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c320500b003fc0505be19sm12638746wmp.37.2023.09.27.07.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:39:36 -0700 (PDT)
Date:   Wed, 27 Sep 2023 17:39:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Amir Goldstein <amir73il@gmail.com>, Su Hui <suhui@nfschina.com>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ovl: avoid possible NULL dereference
Message-ID: <f929f35e-2599-48e4-a77f-f2002bc94482@kadam.mountain>
References: <20230925045059.92883-1-suhui@nfschina.com>
 <CAOQ4uxhv=Theeq0tEiDXEjUcKLNfaZnsVjnweX84mzWYSmFiZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhv=Theeq0tEiDXEjUcKLNfaZnsVjnweX84mzWYSmFiZQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 05:02:26PM +0300, Amir Goldstein wrote:
> On Mon, Sep 25, 2023 at 7:52 AM Su Hui <suhui@nfschina.com> wrote:
> >
> > smatch warn:
> > fs/overlayfs/copy_up.c:450 ovl_set_origin() warn:
> > variable dereferenced before check 'fh' (see line 449)
> >
> > If 'fh' is NULL, passing NULL instead of 'fh->buf'.
> >
> > Signed-off-by: Su Hui <suhui@nfschina.com>
> > ---
> >  fs/overlayfs/copy_up.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index d1761ec5866a..086f9176b4d4 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -446,7 +446,7 @@ int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
> >         /*
> >          * Do not fail when upper doesn't support xattrs.
> >          */
> > -       err = ovl_check_setxattr(ofs, upper, OVL_XATTR_ORIGIN, fh->buf,
> > +       err = ovl_check_setxattr(ofs, upper, OVL_XATTR_ORIGIN, fh ? fh->buf : NULL,
> >                                  fh ? fh->fb.len : 0, 0);
> >         kfree(fh);
> >
> > --
> > 2.30.2
> 
> After discussing this with Dan Carpenter, this is not a kernel bug,
> it is a smatch bug.

Yeah.  Sorry about that, Su Hui.  The ->buf struct member is not a
pointer, it's an array.  So this isn't really a dereference, it's just
pointer math and foo = fh->buf won't crash even if fh is NULL.

I have written a fix for this in Smatch.  I'll test it a bit before I
push it.

regards,
dan carpenter

