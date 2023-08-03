Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C283476F38A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjHCTjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjHCTjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6643C3B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691091504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8fBRKG84oTUzu4cJ0upEFkniwHWsF/Sd26+sDxvy08=;
        b=BF+mX3/m5A2fldN7HUGVozMMj68lo8e76Y09mcEEJNRcc8RsZgWrC6WTmvfLc72zE6MeHV
        EDW4sbdpKA33/QCSKrZ8t2z72594fN2OjAjryJISbPWTsILkdCyWd927pk4Xa4qN7YsY3+
        FMvs4PH26TxAfUjWg9WN7/U2llluc9E=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-v7zvVz-5Nsmi4nPLXSLGIw-1; Thu, 03 Aug 2023 15:38:21 -0400
X-MC-Unique: v7zvVz-5Nsmi4nPLXSLGIw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7873f24e7edso109235239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 12:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691091500; x=1691696300;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8fBRKG84oTUzu4cJ0upEFkniwHWsF/Sd26+sDxvy08=;
        b=L8AkKCLq2TU3fTvrCmRLC18WREHH3rDmwmOcApaV50/jrIkmipNwHE64K+ELrioUun
         D1vPxgYiQcjcLNayFElMkkv78UI1P96Q5UTRFcbJiutddgbymep8YMNoq+uPROvc40C6
         MMjxSItNW3yrK3ElIGnNc1Ph5c6ske8XI2wp5YnTXZrz0VQC8icWYMx8TTWkNe1fwKBp
         nz5SK9PGtZxY2AMCDfrwtpV3KVEuqg0bXabTPeHeWMcTvEXtiLxTEvmBA9sYwvoG4xQc
         M1SkD7i8ZsUA6EsTCH39+bJ0hsfSgYJAuJPgfVJo90pFOK9OxraZwkgxpuFys9U8eYhi
         Zmhw==
X-Gm-Message-State: ABy/qLYv3iHzVp7XjFl7bs5A4COt3ozEFLJ1v6792Uc4uwVaf/4w9sYY
        wdG3iF8hMs6AKbXycocjVsf5j1gTrNXTDA+oUDMdyRxMgmZXsCFDiN3LVSvUtP4zsJ1zCUPRzri
        L4MO/9x71EYt2fu8GjZL7bY/t
X-Received: by 2002:a92:d083:0:b0:349:19e:7656 with SMTP id h3-20020a92d083000000b00349019e7656mr13385730ilh.28.1691091500566;
        Thu, 03 Aug 2023 12:38:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFozrDPoA3AZ5UQWG5fcKBYQDbRoiwLlBgBEKUdt19LvvvypUn54PZ7JdYNXseH/zc0WqTLYA==
X-Received: by 2002:a92:d083:0:b0:349:19e:7656 with SMTP id h3-20020a92d083000000b00349019e7656mr13385718ilh.28.1691091500314;
        Thu, 03 Aug 2023 12:38:20 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id t7-20020a92cc47000000b00345d6e8ded4sm176994ilq.25.2023.08.03.12.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:38:19 -0700 (PDT)
Date:   Thu, 3 Aug 2023 13:38:12 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Roxana Bradescu <roxabee@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kvm/vfio: ensure kvg instance stays around in
 kvm_vfio_group_add()
Message-ID: <20230803133812.491956b9.alex.williamson@redhat.com>
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

Applied series to vfio next branch for v6.6.  There's a minor rebase
involved, so please double check the results:

https://github.com/awilliam/linux-vfio/commits/next

Thanks,
Alex

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

