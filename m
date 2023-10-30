Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642317DC346
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjJ3Xs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbjJ3Xsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:48:54 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9B1E1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:48:51 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b3ec45d6e9so3070593b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698709731; x=1699314531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsVY2jLh2U9WnoNAYl/uNlsEEvjIKweZs2i8GKoaqEc=;
        b=Ho60byUQer0s171gLWTGnH7xOp/6bDMGlN2krjWx/Y/sNrZwXKEa26P0J7QfJRRa+q
         zNjwoLMbGjd3dO3DvK0mUnSf7wSZ/dEJ7uANlmOvNQEdC3diZ06Kx80MpBifxroOx3Jg
         HJKrmVRZiF5foIok6e9o1hI5JIo5NIS77P86CGZUQ/e5E4rI0eenPBlaSydkJnPEZ9ya
         U5Mr/wjCFmj8L+trO7+acWR5zNG9w2HH18Nuf8h7l2Fi92saWYaPC4FNDSJrv7r1b188
         u0LdGyMsKc/nMKq/pASlDYndf6RBZ8D6re3dG/Jw/WtceTZJYuWkENZL2MF0YnfQHknl
         s/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698709731; x=1699314531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsVY2jLh2U9WnoNAYl/uNlsEEvjIKweZs2i8GKoaqEc=;
        b=eqziiCMINftO/FoLpe4yPWn5QGULODzMoYJW/sWziK+ZXocOlc72AgDhEyErWtk4ic
         ntzDSOWRbzMhBJqoraU76zsK9LAUqkkKCW7pRcxM3RWPMjl2heq+PDTxSY+lfUgwQC/9
         iDATnbBFJv8PGUk8bmdQD+jA9C4KKUY1gsbFo7zSPW1F3qnLsk5tVvmdakqI1AYOlZeX
         7/6LJZndDduHeElNTFrIzz/ifXnCmQAsa+S7ZfKSkoDPmoRmJNrPiln1JtwpNuzXGAHn
         bMLmj2P1gd/3jfNXnZyyrOTHCVuUbAi5gzRMWjdbBDu/L52F/nstyWn8RXXo6nnyW6HC
         iYvQ==
X-Gm-Message-State: AOJu0Yw6byIjMIfP4oicp/YqpgweGOcy2TNvrlgPAgtN5nlbMGWEVriH
        wRWISJKF5/XGT+/6H+y9vXFahQpJHQs=
X-Google-Smtp-Source: AGHT+IEAbotmabHHRlVZH0/AHii9mpT6aEswDZ650W1wDN536u21KmA9vSLAu8u+6hqBjwnIApwrOg==
X-Received: by 2002:a05:6808:2818:b0:3a7:2120:8bb with SMTP id et24-20020a056808281800b003a7212008bbmr12312536oib.17.1698709731188;
        Mon, 30 Oct 2023 16:48:51 -0700 (PDT)
Received: from urola ([208.184.224.238])
        by smtp.gmail.com with ESMTPSA id a1-20020a05680804c100b003ae36d664a9sm37852oie.39.2023.10.30.16.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 16:48:50 -0700 (PDT)
Date:   Mon, 30 Oct 2023 16:48:35 -0700
From:   Frederik Deweerdt <deweerdt.lkml@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Add missing NULL check in `tls_strp_check_queue_ok`
Message-ID: <ZUBA0ykjeCesO2QB@urola>
References: <ZUAmyb44sy309V6H@urola>
 <20231030150512.254220a5@kernel.org>
 <ZUAsFeXFOJdo-VzU@urola>
 <20231030162454.628a9c66@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030162454.628a9c66@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 04:24:54PM -0700, Jakub Kicinski wrote:
> On Mon, 30 Oct 2023 15:20:05 -0700 Frederik Deweerdt wrote:
> > > Hm. Can you share the decoded stack trace?  
> > 
> > We could only have screen captures from the management console. I've
> > attached the image to this email.
> 
> Is it possible to enable crash dump kernel or serial console or
> netconsole on the machines to catch a fuller stack trace?

It might me, let me ask internally.

Thanks!
Frederik
