Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0CC763E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGZSMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjGZSMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555E2212F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690395094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eGukCLwIpbf54ieqMBZB+shCMT6w9p/EZv5cgNQmWkc=;
        b=Y2MP3vGPnEdiZ/Xer1W3dYzpOJtXzBmYwo+Cllji3GIYbVjIgfP1+M2Yop0hlY/83TjQfd
        phjswfdrIKbn+Rp9o7KpDbjbbxfiTh13Lh6sI7ASJvds14i1dTOmV/pjIXJs30cCMDNMDg
        p/aF8FffRPAcGWySPqzYCkfhGZjRuXU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-FmN3Ca8_OPm68sa_eBF-Fw-1; Wed, 26 Jul 2023 14:11:33 -0400
X-MC-Unique: FmN3Ca8_OPm68sa_eBF-Fw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-786f4056ac0so3550039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690395092; x=1690999892;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eGukCLwIpbf54ieqMBZB+shCMT6w9p/EZv5cgNQmWkc=;
        b=BO0V5IKEsiz+FDxhI9liGnZewt36ixxdZ75yPmwCliO7ldt057LePVXzXTElzFc6/N
         BQ8ndV0IK4GH4bA+x8qBHxYW64FsJJvpA/b8GoXbwbw15EKnWJgcjK9/vREE94KSTQL+
         5o4nhCY0+pP1WezyZCPuLNqUJLBg7nrU3tXY/ki2SiUJ0VmtnhXOfJXJYJls4j6TZ8Fn
         59VavyabuL44/DAB3miyfVtXi3bfrVjecq+UtIq0HLxnad0X2W/29DHYzwxkGI9vD3r4
         cojKAcpeXmQO8DWtVrTvu8RZb/pbKhL3p/fjId3th3gX7Sl2RiXnIaYnH7arBEWI/EZD
         JA7A==
X-Gm-Message-State: ABy/qLZkBHT+x8AxNrhLhFsUDfXhYvQ/JrIbQMNKgzaifIL53zumnP2Z
        0GETufE+wvxdwuOd/t1PBSgfBcra+fP5JHv0wKSOaJw4LQXvfcBwugBYo7LQnuoD+QBqUR3TCKt
        Ey5TqfmcjQ7SlWCfDBnkSjePG
X-Received: by 2002:a5e:860e:0:b0:786:25a3:ef30 with SMTP id z14-20020a5e860e000000b0078625a3ef30mr2821757ioj.7.1690395092345;
        Wed, 26 Jul 2023 11:11:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEKFEwRNEZtSvBBm6CRwq4z8Y+YP3bImDoHXznPC0Prn+72XzzlCZujlBdG7nGijjkuLmRXww==
X-Received: by 2002:a5e:860e:0:b0:786:25a3:ef30 with SMTP id z14-20020a5e860e000000b0078625a3ef30mr2821733ioj.7.1690395092104;
        Wed, 26 Jul 2023 11:11:32 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id z25-20020a02ceb9000000b0042b3e86dfd8sm4452392jaq.141.2023.07.26.11.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 11:11:31 -0700 (PDT)
Date:   Wed, 26 Jul 2023 12:11:30 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Roxana Bradescu <roxabee@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kvm/vfio: ensure kvg instance stays around in
 kvm_vfio_group_add()
Message-ID: <20230726121130.7117a238.alex.williamson@redhat.com>
In-Reply-To: <20230714224538.404793-1-dmitry.torokhov@gmail.com>
References: <20230714224538.404793-1-dmitry.torokhov@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Paolo,

I'll pull this through the vfio tree unless you have a particular
interest.  Thanks,

Alex

On Fri, 14 Jul 2023 15:45:32 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> kvm_vfio_group_add() creates kvg instance, links it to kv->group_list,
> and calls kvm_vfio_file_set_kvm() with kvg->file as an argument after
> dropping kv->lock. If we race group addition and deletion calls, kvg
> instance may get freed by the time we get around to calling
> kvm_vfio_file_set_kvm().
> 
> Previous iterations of the code did not reference kvg->file outside of
> the critical section, but used a temporary variable. Still, they had
> similar problem of the file reference being owned by kvg structure and
> potential for kvm_vfio_group_del() dropping it before
> kvm_vfio_group_add() had a chance to complete.
> 
> Fix this by moving call to kvm_vfio_file_set_kvm() under the protection
> of kv->lock. We already call it while holding the same lock when vfio
> group is being deleted, so it should be safe here as well.
> 
> Fixes: 2fc1bec15883 ("kvm: set/clear kvm to/from vfio_group when group add/delete")
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v3: added Alex's reviewed-by
> 
> v2: updated commit description with the correct "Fixes" tag (per Alex),
>     expanded commit description to mention issues with the earlier
>     implementation of kvm_vfio_group_add().
> 
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

