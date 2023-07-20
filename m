Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E375B888
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGTUIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGTUIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D512118
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689883679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OE0EV6J+vzod3PsQDGt8r4M/mtNB6OQPBXWG+V0DKPY=;
        b=d0Wk/iwdf/Ruk9ohyEM2K7kMieGnA2Izyaqv5JcVrmnC3sVkE3yY+78lYTOfOTnfXLpZac
        L9LWtk62NqczYSPzmXbXzmpv1aTL7DSWZyBWSbHB+AAIAKVFjsnenDV6CR0GWhF/RDorgr
        U99GKp6biAXlhzyry5t96SyBMB6qUoI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-Aqiqjui-P566Iu9Og-5Yqg-1; Thu, 20 Jul 2023 16:07:58 -0400
X-MC-Unique: Aqiqjui-P566Iu9Og-5Yqg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7672918d8a4so33907485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883677; x=1690488477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OE0EV6J+vzod3PsQDGt8r4M/mtNB6OQPBXWG+V0DKPY=;
        b=SWmu7PRpldeJN9WHMvojWDX0jAvKkXhDvhDYO2r8S4yv1+FUOtLPZqbm/Azp/bunI/
         mZI7vtbHd5v+LBYnR3Qg55tRzvwn00fuCZBOINH3szzy5VMW+x+y/jkgfcxxISt1IAwp
         LKSYGYcUZmi4oUkO/sqxjmFDq66gxwYKJnEv+4Gpv72+8TcWGAMT6jDSGCafGdOs1/4d
         lU9pJThVmIHm0+yW6yD9OYQoc4zS6cw0RgjdLWnYQzP1TEbwfIZdSivf8Du+4LWnWWlH
         4xzzRb0Iec1CRl8bgMuAzsRw33CMEQjXYYtrX7Y6Mz3SGSfp/Ce2AaSAZGyEchs8iQNq
         iysQ==
X-Gm-Message-State: ABy/qLZXAIcVQfe5BMVb9pO2iej7kaKrNrfH8vjZzoKUWOkmWCS+cR/h
        fBqquftyWDX8TfioocNW2+7Ogt7m5HONRdnQ+t+74YYv4Gg8evaGM75nPJduhuK5nFre9dg4C11
        kSQDcdz6/IZscGVfpt2t4+Z09
X-Received: by 2002:a05:620a:17a4:b0:767:e5cd:1519 with SMTP id ay36-20020a05620a17a400b00767e5cd1519mr4104982qkb.6.1689883677633;
        Thu, 20 Jul 2023 13:07:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFcKwCKWR6jl+1R33BvlrSIBZ7RCNis3PBR+MXtzMIRJ/11Z7wrMpT4bIBpmaLZZajTBFrGbQ==
X-Received: by 2002:a05:620a:17a4:b0:767:e5cd:1519 with SMTP id ay36-20020a05620a17a400b00767e5cd1519mr4104970qkb.6.1689883677323;
        Thu, 20 Jul 2023 13:07:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id g22-20020a37e216000000b007677f66b160sm581885qki.124.2023.07.20.13.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:07:57 -0700 (PDT)
Date:   Thu, 20 Jul 2023 16:07:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Dimitris Siakavaras <jimsiak@cslab.ece.ntua.gr>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
Message-ID: <ZLmUHI+iyhj6QcYL@x1n>
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
 <20230719211631.890995-1-axelrasmussen@google.com>
 <20230720103534.312-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720103534.312-1-hdanton@sina.com>
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

On Thu, Jul 20, 2023 at 06:35:34PM +0800, Hillf Danton wrote:
> On Wed, Jul 19, 2023 at 2:16 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > I think perhaps the right thing to do is to have handle_userfault() release
> > mmap_lock when it returns VM_FAULT_NOPAGE, and to have GUP deal with that
> > appropriately? But, some investigation is required to be sure that's okay to do
> > in the other non-GUP ways we can end up in handle_userfault().
> 
> See if making kworker special works.
> 
> --- x/fs/userfaultfd.c
> +++ y/fs/userfaultfd.c
> @@ -457,6 +457,8 @@ vm_fault_t handle_userfault(struct vm_fa
>  		 * close the uffd.
>  		 */
>  		ret = VM_FAULT_NOPAGE;
> +		if (current->flags & PF_WQ_WORKER)
> +			ret = VM_FAULT_OOM;
>  		goto out;
>  	}

Sorry this won't work - we need userfault to work with all forms of
kworkers, especially including kvm async pf. Thanks.

-- 
Peter Xu

