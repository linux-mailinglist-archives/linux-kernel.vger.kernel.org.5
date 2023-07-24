Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52BF75FDE5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjGXRh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjGXRhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78052D3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690220191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kNGMSM8bxe1gWl9DKNB8FIofvuGTxcy8H7Yww9mrYIY=;
        b=UFA076dOOnxqxplg042wUUbYzcLFn4JPs8YrBvObruixP7F/ko91YCvOCXngi0gAsrq6NE
        iO0NIPOaQQu5ODl21VJSPMLOaH9+UHkx5uZrsyXqhNzxjUdgs/CYAGIVkS9Lv7Sy+qsunr
        xFJh6vMjlNXFbfz3Ev3CZ1a6ftIfK3s=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-P27huBNEP2i6SjlorolHOQ-1; Mon, 24 Jul 2023 13:36:30 -0400
X-MC-Unique: P27huBNEP2i6SjlorolHOQ-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-44351c72d62so795344137.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690220189; x=1690824989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNGMSM8bxe1gWl9DKNB8FIofvuGTxcy8H7Yww9mrYIY=;
        b=cUikFILpL5K7KWAB8JyujBGkf+A3dpx5WIvv5bH7GnVY3KpFzrkMp31/v6AZqPKSLN
         w9BXEazMbJdgJ+MyiAx4Fc1yyIFrCOA/9zlyoTQ35wSjpVLgHkWe9ZUzXt3kfp0Kthbo
         L91KXbq3YmnNBMJlM8vlj48j5F7/iAbqY/SEnTqsikrpLWqrmxq0JanS+3X1YujF+seN
         eqcmV60VDfg9Q2a76QPdjnpjGlGI9x8ZqnGDtGUmWwPzLfEW36RaC9Ed7ewr6feBLEIG
         zJOKU7Qg4o+36Jm6N1pvwpChWNPV/riDbpj6MPUMhESU3lfpEdrxrQTMnlSGKaPhOTpt
         rAzA==
X-Gm-Message-State: ABy/qLZG/n0dDTJJralrWm1jOwg5SL4cCy3YoOB/nfrMUQC7dzhmC/Jl
        S+lahUvs9k/U+CKfayQ/Akl54brzcv/MLNnT4po3gEcguQt1LBprupBTtM4dAKqJmeZTRQmmXTC
        2KhA+MhO4spXlbvjf4e7pbN4FCiQNx850plrTyoMy
X-Received: by 2002:a67:f8d1:0:b0:443:6052:43ae with SMTP id c17-20020a67f8d1000000b00443605243aemr3299078vsp.24.1690220189676;
        Mon, 24 Jul 2023 10:36:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEPDqGTgQT6TM0EZ/andXcsJaVfqEGx4nspzB3wq5naiCL3fLJVYaemN8sLojXqmdOKsQ5G89TIgjY7tVB3FGk=
X-Received: by 2002:a67:f8d1:0:b0:443:6052:43ae with SMTP id
 c17-20020a67f8d1000000b00443605243aemr3299068vsp.24.1690220189488; Mon, 24
 Jul 2023 10:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAASaF6yKxWaW6me0Y+vSEo0qUm_LTyL5CPVka75EPg_yq4MO9g@mail.gmail.com>
 <7854000d2ce5ac32b75782a7c4574f25a11b573d.1689757133.git.jstancek@redhat.com>
 <64434.1690193532@warthog.procyon.org.uk> <10687.1690213447@warthog.procyon.org.uk>
 <20230724100914.38f286a5@kernel.org>
In-Reply-To: <20230724100914.38f286a5@kernel.org>
From:   Jan Stancek <jstancek@redhat.com>
Date:   Mon, 24 Jul 2023 19:37:08 +0200
Message-ID: <CAASaF6z27XJGhn_7uX+KXrTFoi6KtK4Oxp1b_OZ7dW8yEH9X5Q@mail.gmail.com>
Subject: Re: [PATCH] splice, net: Fix splice_to_socket() for O_NONBLOCK socket
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 7:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 24 Jul 2023 16:44:07 +0100 David Howells wrote:
> > Anyway, did you want to post this to netdev too so that the networking =
tree
> > picks it up?  Feel free to add:
>
> +1, no preference which tree this goes thru, but if no one else claims
> it please repost CCing netdev@vger.kernel.org

I'll repost, thanks.

