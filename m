Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2D752A78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjGMStK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjGMStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F83A1FFD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689274097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGeXPloclWmXx75C2ODitSLZL0CWOSuZ45NynWXgvA8=;
        b=EFH2JbmOCulsDqY4NrT1tVb2i7+Mly/fBvUeJhzxYw+OS5Sqd65UsOFGYj2AbpqcZ22IYH
        +O2F9XOKgCQX3tlZZAyD6mF1U1SXiFXS90qDCd7C+yWJiFVGNt7qU/D2k13LSv/TWzPduZ
        SCrVL8BOtbDaS8VKkBG0CE0KoLyPRfc=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-WjR9kIzrNUubuFRW15j2qQ-1; Thu, 13 Jul 2023 14:48:15 -0400
X-MC-Unique: WjR9kIzrNUubuFRW15j2qQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7866b037d4dso44659139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274095; x=1691866095;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGeXPloclWmXx75C2ODitSLZL0CWOSuZ45NynWXgvA8=;
        b=TREsHaOvPhetqmRiqlrzHfSHdjnfNPT1Tl74I10XMGYtB/Sp2073+pYaF9F1XSj/GZ
         ak9izVe3OkptBL2QhPb0EW44y6xvmkbpZg/hTFNuOa0suvAyEg2asw9AewBz5fquD6hd
         748lSqTOioQo7CLlQBbtBCTLi/cOnPefHo7Cs7xHYYjwsgCURiOW65+ykJdy5KwVTLJ3
         WqyXXGULf7Fh/woHdMM4wwFTEbTVWLb3gl+9KKJtW/Ut37GgTM3QhxutLW35+Ct77OZq
         jtZ0D5QCYgVHf5ce9+u7GqtmoDx2kBvrlPGk+hWp4Os4WIp78SJn2ekA68d6amHZOYaM
         WK1A==
X-Gm-Message-State: ABy/qLYsArG9ucJgRnGNWOvt7I+vefGmaqQ3WR0FSPnnSgF81z260QDA
        SesPAulzO7VVP+Gua1hEbtLn8ju3bJ97BWpwg25tRm/uAFdaCN2fz4W0F6KVgvwPS6O0dCSHEgt
        zWXsxlNXFDImlED3CLjAAnJPc
X-Received: by 2002:a6b:5b04:0:b0:783:4f8d:4484 with SMTP id v4-20020a6b5b04000000b007834f8d4484mr2887300ioh.2.1689274094760;
        Thu, 13 Jul 2023 11:48:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEcdTiwuoB1o1GizuzCA0x86eJCUtj213Gw+KMyxSsO5/E54xICiIlBvF9z4FhyXK7+Ke6hTg==
X-Received: by 2002:a6b:5b04:0:b0:783:4f8d:4484 with SMTP id v4-20020a6b5b04000000b007834f8d4484mr2887284ioh.2.1689274094497;
        Thu, 13 Jul 2023 11:48:14 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id f9-20020a056602038900b007862a536f21sm2144351iov.14.2023.07.13.11.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:48:14 -0700 (PDT)
Date:   Thu, 13 Jul 2023 12:48:11 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Roxana Bradescu <roxabee@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH] kvm/vfio: ensure kvg instance stays around in
 kvm_vfio_group_add()
Message-ID: <20230713124811.1b3c1586.alex.williamson@redhat.com>
In-Reply-To: <ZKyEL/4pFicxMQvg@google.com>
References: <ZKyEL/4pFicxMQvg@google.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 15:20:31 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> kvm_vfio_group_add() creates kvg instance, links it to kv->group_list,
> and calls kvm_vfio_file_set_kvm() with kvg->file as an argument after
> dropping kv->lock. If we race group addition and deletion calls, kvg
> instance may get freed by the time we get around to calling
> kvm_vfio_file_set_kvm().
> 
> Fix this by moving call to kvm_vfio_file_set_kvm() under the protection
> of kv->lock. We already call it while holding the same lock when vfio
> group is being deleted, so it should be safe here as well.
> 
> Fixes: ba70a89f3c2a ("vfio: Change vfio_group_set_kvm() to vfio_file_set_kvm()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  virt/kvm/vfio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 9584eb57e0ed..cd46d7ef98d6 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -179,10 +179,10 @@ static int kvm_vfio_group_add(struct kvm_device *dev, unsigned int fd)
>  	list_add_tail(&kvg->node, &kv->group_list);
>  
>  	kvm_arch_start_assignment(dev->kvm);
> +	kvm_vfio_file_set_kvm(kvg->file, dev->kvm);
>  
>  	mutex_unlock(&kv->lock);
>  
> -	kvm_vfio_file_set_kvm(kvg->file, dev->kvm);
>  	kvm_vfio_update_coherency(dev);
>  
>  	return 0;


I'm not sure this hasn't been an issue since it was originally
introduced in 2fc1bec15883 ("kvm: set/clear kvm to/from vfio_group when
group add/delete").

The change added by the blamed ba70a89f3c2a in this respect is simply
that we get the file pointer from the mutex protected object, but that
mutex protected object is also what maintains that the file pointer is
valid.  The vfio_group implementation suffered the same issue, the
delete path could put the group reference, which could theoretically
cause a use after free of the vfio_group.

We could effectively restore the pre-ba70a89f3c2a behavior by replacing
kvg->file with filp here, but that would still leave us vulnerable to
the original issue.

Note also that kvm_vfio_update_coherency() takes the same mutex
separately, I wonder if it wouldn't make more sense if it were moved
under the caller's mutex to avoid bouncing the lock and unnecessarily
taking it in the release path.  Thanks,

Alex

