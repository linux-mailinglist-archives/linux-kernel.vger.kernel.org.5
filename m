Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B013D803412
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjLDNLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjLDNLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:11:30 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35FAD2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:11:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3333a3a599fso952841f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701695495; x=1702300295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7CvBb5ez2rIHJbMByjNRmxDcnijZJnzjRDM0SVuuo8=;
        b=dd5nxUVxQaJnV3E51oxOIgChhhlRYhyjPNgo/meQd8WlJkTSElmihMnt2JD7t3KIM8
         aELRsVSgxLqD0hGrByfBVBtNwbVDrWLJyaXbPYVO41YAQcGFVNBRhEUjAqHVA/VQg6t8
         3qdJzaVR/u2iwh4xPKEqYbpKIq+qCCp33BkoUro4yyky11xpGncNNEb1ZqKBdjYN73nQ
         ZkrvaDEeS8hBKoiCpexbw9Q4z17RBfBoGxO2FkRV2dEPdfcMV82zl+8QhZyf+xnIK8O9
         Dwh90uncsZmUUfjn/JbY310iuN50N7lrkSALWmkBKXtWsZYzKBw9WuCPWvNh67r9xE0J
         LJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695495; x=1702300295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7CvBb5ez2rIHJbMByjNRmxDcnijZJnzjRDM0SVuuo8=;
        b=qDbPrGUMg/4XAcQORapS3kouZJLriRTUB/9nTN+MV+bHCtxxw0nwZmDoPZvpOSdq/e
         tUwaDpCGjvMAcAuqgYZLWIlhE8vIgzWObVoFFiXTa7vrbZOHS1A4YFej2/I0ZZFaaO9X
         tuBVdV+sK2iFcOjUgm2HMH+SItt5X7ANKOTfRqsdgXuhsAm7ojSwW+3nEd7+eDHKflrz
         i/fHbtkzFTEjlR1xNmy1W667HfXGYLJg+uA7Hjo61lWpIPBNCM95t84wKxJ6EOqfBfTv
         fCZU6n1j2mBFoTYOJvs1zAORu4XFu8ywONNNNyq8bJ29+9ih37X2MkMNc3RgNUzyM64w
         vlKQ==
X-Gm-Message-State: AOJu0YztJ+oe7hBwlRigGEib+1G1/pLx4YXaABfHMTD5tpab+iLNXX6H
        h1wEhGHDHxs9iJQd17lKR719s/Nv6Ru+ajzkULk=
X-Google-Smtp-Source: AGHT+IHw4m55StfKreagQZR9FEW5SpMZuKW7wPpRItxPU+RJscZo0a8NGKblqE4YoqlOtE3KO/Q3zg==
X-Received: by 2002:a05:600c:4fd2:b0:40b:5e56:7b47 with SMTP id o18-20020a05600c4fd200b0040b5e567b47mr2967883wmq.144.1701695495247;
        Mon, 04 Dec 2023 05:11:35 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c311200b0040b42df75fcsm15017507wmo.39.2023.12.04.05.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:11:34 -0800 (PST)
Date:   Mon, 4 Dec 2023 16:11:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Su Hui <suhui@nfschina.com>, alexander.usyskin@intel.com,
        tomas.winkler@intel.com, arnd@arndb.de, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] misc: mei: client.c: fix problem of return
 '-EOVERFLOW' in mei_cl_write
Message-ID: <bd13cda0-6437-40fa-a73a-9770be6f0167@suswa.mountain>
References: <20231128014507.418254-1-suhui@nfschina.com>
 <2023120452-stool-party-bf2b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023120452-stool-party-bf2b@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 09:00:42AM +0100, Greg KH wrote:
> > diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
> > index 7ea80779a0e2..0489bec4fded 100644
> > --- a/drivers/misc/mei/client.c
> > +++ b/drivers/misc/mei/client.c
> > @@ -2033,7 +2033,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long time
> >  	hbuf_slots = mei_hbuf_empty_slots(dev);
> >  	if (hbuf_slots < 0) {
> >  		rets = -EOVERFLOW;
> > -		goto out;
> > +		goto err;
> 
> Please prove that this is correct, as based on the code logic, it seems
> very wrong.  I can't take this unless the code is tested properly.

Hi Greg,

When Su Hui sent the v2 patch you sent an auto response about adding
stable to the CC list.
https://lore.kernel.org/all/2023112042-napped-snoring-b766@gregkh/

However, it appears that you still applied the v2 patch.  It's in
linux-next as commit ee6236027218 ("misc: mei: client.c: fix problem of
return '-EOVERFLOW' in mei_cl_write").

When I use `git am` to apply this patch, then it doesn't apply.  However,
when I use cat email.txt | patch -p1 then it tries to reverse the patch
and apply it to a different function.

So this a kind of confusing thing.

regards,
dan carpenter
