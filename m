Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE97CEA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjJRVz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjJRVzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E78898
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697666081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jWkQJoQJpr/+kS89LQbgqhi6sZMu3/0SRnAPjzjxsM=;
        b=irvYNCDfLj4WGsxW1NN4FKRInzIQ6lUVP+lmPZpLJpL/93T+K7ZySmkjV+JpkcyWpGMOKe
        PWq7dpKKSZdtP3cHAwtpvpezyNluLlufH1qStkgkkAZZHJGW1544kPBQmV5k/0r0W+c1xx
        HoLt156LHpiO4AnyHgWzH7z1RwMhL/U=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-Tmin_PY6MoKXdq8MTqA8hQ-1; Wed, 18 Oct 2023 17:54:34 -0400
X-MC-Unique: Tmin_PY6MoKXdq8MTqA8hQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c51a7df557so42905781fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697666073; x=1698270873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jWkQJoQJpr/+kS89LQbgqhi6sZMu3/0SRnAPjzjxsM=;
        b=kGqnavWaddhu4Lda44aEAk5MJdv/DSMD5CEh++x0gwZCBiV/dZAdwKBi54+x1uVKIR
         rH2lsvWgMz1HZswIQc7JSOb30SBJBPLtsIt6eQjIcYoIS7OWTA5E7pbJXvtIwffKxg0S
         7OUqwRRgd/yZV6PY3KGUfXhURXNJ1Qoc3wLFt/ZKKIZcvvVy3ZNXiTheBWrvjzT4/lzm
         Eb522K90Eade3u6snwOq4TBaRS0fYsaTbm+4va+wZL99ecaRahVLM2uD7vW0qCVDYdsJ
         TJK9kU23gtIYfCLoqLWfYYbEjW6aVeSmom2xcG2a1+zerUYBsISVzNgzvnHyQuADRklb
         5BHw==
X-Gm-Message-State: AOJu0YxKEZ1bhLPd7VKhAoWmXJBx5HviCBco4jz9zLeiuiAixz2sTzPx
        0eiiE3dGDN9o42EPbbWulN5e+vLZimRu6SwIMBLgOXuvfrPJspjm5sbyUSzw+tHYsgdskjHyd5R
        6aQrqGuouXRYq4JIcu5Ac8eJ2Ewn+e2NOq3M=
X-Received: by 2002:a05:651c:1542:b0:2c5:1d11:5688 with SMTP id y2-20020a05651c154200b002c51d115688mr163169ljp.14.1697666072875;
        Wed, 18 Oct 2023 14:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgbtzM61FKFYPQPOG7eZJ70Sg/h1vdwbbcL0MLTkVKZ5S1zlAptVNOKCFfQ5SYbpcvcaFMOA==
X-Received: by 2002:a05:651c:1542:b0:2c5:1d11:5688 with SMTP id y2-20020a05651c154200b002c51d115688mr163157ljp.14.1697666072515;
        Wed, 18 Oct 2023 14:54:32 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c1c8600b0040839fcb217sm2774655wms.8.2023.10.18.14.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 14:54:31 -0700 (PDT)
Date:   Wed, 18 Oct 2023 17:54:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the vhost tree
Message-ID: <20231018175411-mutt-send-email-mst@kernel.org>
References: <20231019084309.3bda85c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019084309.3bda85c4@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:43:09AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   34ad6689c509 ("vdpa/mlx5: Expose descriptor group mkey hw capability")
> 
> is missing a Signed-off-by from its committer.

Fixed, thanks for letting me know!

