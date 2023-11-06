Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB757E1ECB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjKFKr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:47:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08934FA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699267602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y6QcvY42P7J5f+1XN4Qoz7DTeNEAzvUSzxn7o+ZphKQ=;
        b=UXuvy783ljVnl/qQxSadI5dwB9V4aYW04zp8wUkYemb1HI/KQMZhXihLbBIUuCD580pkZi
        w0WJGLtJ3MwgNtZ4m0g8UH2DYBrASvIZbZg3aVpi7sjCMthmoLe4PCt5xufBrmCCvqU59d
        i7iDruZ0wUB9lZqd0+UtBY7Qrs9jVtQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-oUQnfsfuM6ykOr0AqrLbqQ-1; Mon, 06 Nov 2023 05:46:41 -0500
X-MC-Unique: oUQnfsfuM6ykOr0AqrLbqQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7788fb069abso656304085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267600; x=1699872400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6QcvY42P7J5f+1XN4Qoz7DTeNEAzvUSzxn7o+ZphKQ=;
        b=k0NHGK2UM1vDJn3CFdHiGYtk6yaCFIvVfiVNyx/na8iFVPGGa93jiMn2iU+Q2r/lkw
         AmLxMb/x6zjD5LSAjzy917Ol5UTbJFfySHtI120DPRfVlRtH3hWgvdnUjAugu7Mn8wQk
         ZfQsLp/M3ybUls5dGCM+zycJGt8gJD2hsk9WAFrNXcUGDAh0auPwu7XtFERL1VFcjpeA
         fL4v6rWYnddfLL8qnJJs7rp7niKE9nxgsCkxSTrAuHFD8Hfhv50MOCxd1OKuMFC8s/mK
         Bs4RnYx6Dh5Two5J6DtGIgGqk+IGL5AW6z01Dfi2kD9nBSMe4pZWDWGGSTKgnOXWWw3X
         XdHw==
X-Gm-Message-State: AOJu0Yx9DCo7Si1uxmQftKv/bVIhFtRKZTFdNLUIFEPHjHwXS1EHwLnE
        qM41dQMyQDIGAhBGiGg+q8wyuEKzMr/I37kkr5iAhfaRP2F/Aw7LgizbUfPTx1ZMkaacaGwQkG3
        jZpgdwcTjGs761dCB82QVNW0S
X-Received: by 2002:a05:620a:4622:b0:779:cf70:8495 with SMTP id br34-20020a05620a462200b00779cf708495mr13042343qkb.22.1699267600590;
        Mon, 06 Nov 2023 02:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0MTPNegxkHg2EtjSBJdIkcLWvJeBZhkiYCgUyFVAeJU8p43NP4uMhUlLf+FYjn63g6E1jfw==
X-Received: by 2002:a05:620a:4622:b0:779:cf70:8495 with SMTP id br34-20020a05620a462200b00779cf708495mr13042320qkb.22.1699267600334;
        Mon, 06 Nov 2023 02:46:40 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
        by smtp.gmail.com with ESMTPSA id ay18-20020a05622a229200b004181c32dcc3sm3258973qtb.16.2023.11.06.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:46:39 -0800 (PST)
Date:   Mon, 6 Nov 2023 11:46:26 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     f.storniolo95@gmail.com
Cc:     luigi.leonardi@outlook.com, kvm@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, mst@redhat.com,
        imbrenda@linux.vnet.ibm.com, kuba@kernel.org, asias@redhat.com,
        stefanha@redhat.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net 2/4] test/vsock fix: add missing check on socket
 creation
Message-ID: <dhech4poimv5fphsxpy4oxy5ks5kpki6kzboy6kpnfm65vz3tp@nm6hoicgj5ze>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
 <20231103175551.41025-3-f.storniolo95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231103175551.41025-3-f.storniolo95@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 06:55:49PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>Add check on socket() return value in vsock_listen()
>and vsock_connect()
>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Filippo Storniolo <f.storniolo95@gmail.com>
>---
> tools/testing/vsock/util.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

If you need to resend the entire series, maybe you can remove "fix"
from the commit title.

But it's a minor thing, so I would only change it if there's something
else that justifies sending a v2:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 92336721321a..698b0b44a2ee 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -104,6 +104,10 @@ static int vsock_connect(unsigned int cid, unsigned int port, int type)
> 	control_expectln("LISTENING");
>
> 	fd = socket(AF_VSOCK, type, 0);
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>
> 	timeout_begin(TIMEOUT);
> 	do {
>@@ -158,6 +162,10 @@ static int vsock_accept(unsigned int cid, unsigned int port,
> 	int old_errno;
>
> 	fd = socket(AF_VSOCK, type, 0);
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>
> 	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
> 		perror("bind");
>-- 
>2.41.0
>

