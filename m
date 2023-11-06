Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5C37E1B37
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjKFH2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjKFH2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE4112
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699255672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=43URkpYtRBGE0OYmyASXAaiR9gWD2J5xkyb/eiFUiBk=;
        b=RsLu0LKqlCFfQcEsvKKaKTbNgRvqrpVw3W3Ox8fFDgPbhqWRMrQdLeuAGAbBmT2YocJHuH
        P7FZ+LH6jVcu2abILAPooko8H42TcRLnApp7j2Bmnk1Kx7/84bwJUeKLKKYUuRg4GDLUXk
        LIoTdZSWSgsvuVALSteJRUSpQDNf9wU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-Uw46tjn9O-CbqAbmUszfSA-1; Mon, 06 Nov 2023 02:27:51 -0500
X-MC-Unique: Uw46tjn9O-CbqAbmUszfSA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5079a8c68c6so3858153e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 23:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699255669; x=1699860469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43URkpYtRBGE0OYmyASXAaiR9gWD2J5xkyb/eiFUiBk=;
        b=SMnzqBN6rdzVgnk8j5hEY7+pdx4jPmQHJY6/hktxglZa4SFFyjXcCBFIEJ4vItZ6ow
         W0vC5FSPQ4NeudFEX7P1r9HpniuDyflOvWuKtkd/5iFBKVTVI7hdmpU5EfDt63e+KiTu
         0rH/JJQ6MK/vYtDAOc1dFT0i4iEYKbGvvtvZiPzRI47GQk8QinmAOzJRfn6vRdOsGlyB
         SeUxrPg3f4R/5+C/m+eqGAQ01aTJJSnLoB8cq95wPnBqDqHH98+BXSPoARXzYHyaRdnj
         Zay3TmTp1oluLmPISAlJbk9pwgSh2S/+xdMjRiC+PCTxzfFlLmytx2OIvCdjs1UQdyQM
         R2Rw==
X-Gm-Message-State: AOJu0YyYpADm5DGOkpnHStZAx0GOVwpTLdUZxZweamhBsM6OVdym6Gfx
        arZergWhVVT6dEM573I9gjh4xmM8kpB7eEX9Bu/ImEIiPt87RD9+SkhrYmsZthuUnnXyDwu0VHJ
        m1v9onNJzmsdc0qG7IyPt12q4yZ2lsjrIXSPc7BEN1lY4rKczWC8=
X-Received: by 2002:a19:e011:0:b0:503:fc2:bfaf with SMTP id x17-20020a19e011000000b005030fc2bfafmr19235615lfg.33.1699255669566;
        Sun, 05 Nov 2023 23:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeuHCmPxbI1vFCSmuwsvTXlqbF/Vv6BpaewiH5OFPHTfdUlAVBDe19efaIgP47YNORg4NZHGPl5Yde3mGZKnw=
X-Received: by 2002:a19:e011:0:b0:503:fc2:bfaf with SMTP id
 x17-20020a19e011000000b005030fc2bfafmr19235608lfg.33.1699255669287; Sun, 05
 Nov 2023 23:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-4-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 6 Nov 2023 15:27:38 +0800
Message-ID: <CACGkMEt+HRZbCDGUefu268P7+0QffDpMA-RHzArhjZ2i-zRWEw@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
>
> VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
> address space specified by IOAS id.
>
> VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> from the iommufd address space
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

As discussed in the previous version, any reason/advantages of this
compared to just having a single  VDPA_DEVICE_ATTACH_IOMMUFD_AS?

Thanks

