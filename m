Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52E3812E80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443853AbjLNLZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443635AbjLNLZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:25:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F747B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702553131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9WOSGNm88GlKvElNEORSdf+9gAs7IEiznRYRNcmrsWY=;
        b=B1uuKvVyLThAMStXd9E0EKLcaQN9YoiXjIJ48bdI29fybnLTAg831DNDxhd/J+SsYEvkO1
        Ub8yQTZn1Dy0V1umsXvaQKJ+AJLSuw01k+zBgMOvuXQz4JLS7Gz46/izBWdbHKgA5Xahn2
        cL0KNG4x7kIliY+siDl/Qf0hfTuTO7g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-wvmlC2tCO3KLNYTxdLTTiA-1; Thu, 14 Dec 2023 06:25:29 -0500
X-MC-Unique: wvmlC2tCO3KLNYTxdLTTiA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c41b91a1fso35735725e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702553128; x=1703157928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WOSGNm88GlKvElNEORSdf+9gAs7IEiznRYRNcmrsWY=;
        b=q82ZywGU/K7aYo0fJTz1MV3GWnkoayDa9CjNSST0WdJ/px5A2SiQKNZheS1G+tomcI
         /qm+Yy1266ulVMdC5rT+81wGkAnSyYZvm/Vky+P6mr3TpJbzhQ0ZLzjdZWivWEbEvJ1Z
         FvV4cm8ScWKLP2HLQFRxiUs9Xo1sTpnGh9Hg57/hxmvAcBA3JPayD0Qck4LMwY8uJnIP
         ZOMeWiqqTKxjbhfk68osHlwLZkQQGHP66hmeyT6FvGML7Qwu7+2Y6wYxku6uI/3XniUZ
         yErDBvvxswT+C2A4EYEcXp6G1VVG3s6EoItZNfY+sTBoHwlq11Urwi1kkeovvnPe31Ty
         oLQg==
X-Gm-Message-State: AOJu0YycW+lmibfkaxjnpi7l5pCDbbcolOfHgcAappEqGTMWPQiwwndW
        rrKTxhmTrm/I7SP/jcwaxmaImXlnBnnGBsNzrlDzosg03UClMfEoHigMcbHk2+CJ2v2gO9BgwXh
        QuDTlA8gmspNe8SUWD3obhQD3
X-Received: by 2002:a05:600c:829:b0:40b:5e21:c5aa with SMTP id k41-20020a05600c082900b0040b5e21c5aamr3285703wmp.120.1702553128702;
        Thu, 14 Dec 2023 03:25:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEnzeMVo5DgwkNjHZ+U7ve6Fx6zxmptRwmIvA97Tf0v1/JFlDUo/l0u3XrgPk6UfHgSHyiIw==
X-Received: by 2002:a05:600c:829:b0:40b:5e21:c5aa with SMTP id k41-20020a05600c082900b0040b5e21c5aamr3285701wmp.120.1702553128342;
        Thu, 14 Dec 2023 03:25:28 -0800 (PST)
Received: from localhost.localdomain ([151.29.78.8])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b0040c45cabc34sm15878122wmo.17.2023.12.14.03.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:25:27 -0800 (PST)
Date:   Thu, 14 Dec 2023 12:25:25 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZXrmJYvekzrLSaGo@localhost.localdomain>
References: <20230729135334.566138-1-atomlin@atomlin.com>
 <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
 <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
 <ZXguMgcKLCLn16T4@localhost.localdomain>
 <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
 <ZXlyfjDsFGbYcMU6@localhost.localdomain>
 <ZXnPVtISKQ2JFDNn@slm.duckdns.org>
 <ZXn4qiMetd7zY1sb@localhost.localdomain>
 <ZXn6J5bN-dPC1WSk@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXn6J5bN-dPC1WSk@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/23 08:38, Tejun Heo wrote:
> On Wed, Dec 13, 2023 at 07:32:10PM +0100, Juri Lelli wrote:
> > > Maybe the easiest way to do this is making rescuer_thread() restore the wq's
> > > cpumask right before going to sleep, and making apply_wqattrs_commit() just
> > > wake up the rescuer.
> > 
> > Hummm, don't think we can call that either while the rescuer is actually
> > running. Maybe we can simply s/kthread_bind_mask/set_cpus_allowed_ptr/
> > in the above?
> 
> So, we have to use set_cpus_allowed_ptr() but we still don't want to change
> the affinity of a rescuer which is already running a task for a pool.

But then, even today, a rescuer might keep handling work on a cpu
outside its wq cpumask if the associated wq cpumask change can proceed
w/o waiting for it to finish the iteration?

BTW, apologies for all the questions, but I'd like to make sure I can
get the implications hopefully right. :)

Thanks,
Juri

