Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9061A8036D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbjLDOdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjLDOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:33:39 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7AC3ABD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:24:05 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4b2d237ab87so322093e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701699844; x=1702304644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaBLe1cZFsz9gEp4lVhVDjfyffYP1pw8mzotW316g4Y=;
        b=h1GUep3NhWulNleHajGa70Wqx5KKz9MqeJwb4E36PpV4vOHBCVj2drKCe7O7q7blC5
         2cDK3u0jTPiOoQLbzMHtPIynmblK5vdIhGaj5osoOWSw4nLwPzhON1b9DEtQsAGAfMvP
         7bYlBwlMmq/yI7UPblzekRtppPTkIiVWTY4fejP6dyVyyhXks1FdkREsUCklgTfQBjLv
         obX0Plqobde16xjQVC3CquXSNVv97X9cUPJKo5lTjaFF1O5zLZV7w413I2phEsGLKnUa
         akTWJUyfPE8pyERqs2rjgZbg+cyUlMIbogFOGDKpYzdtpRABtfKrd1hM4KUc4j0ioJF1
         WdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701699844; x=1702304644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaBLe1cZFsz9gEp4lVhVDjfyffYP1pw8mzotW316g4Y=;
        b=hcIZxZwC8TOALAY8XoME+HjvEZNSxqmnogfIwGOnd/KSkqadHKo9rEfeI73QehSzlP
         83wPslBT81rpvjGrLkcvQzZLRbLKUdLwzQFAE8nslc7YYOAInx2g6rDVZMU4IFv3DkKe
         zf0evrK7AEKJOsG7Ytow7YocE4Rm2syfE6lLUj7YgTER//TBmaDFsDzHgcApDAebDE9q
         KbK8X0NA3jp0+aSqSx5T/CcNMHaMMX9PwBddshgy45kygOEwoAHybZOSsMrVHR56V21M
         6V0Nh4XJzS5P4086WKKv4n0gjMOoeRH17i+4ObbpYPsWU3fOqDk3JjzP2Hk+3BtfkAjm
         NY9g==
X-Gm-Message-State: AOJu0YxqmBJfKyEifK95fjnKoxtt0474RkFvoH6/UOIYlmxKl04uKGmx
        UGuIcKo3LNY5uefeQYKlFljTtv4c9QC9vjhwKavTXA==
X-Google-Smtp-Source: AGHT+IH4nqTK2DR96olJWeUMLo3ok8bQakofeYUjUMWWplhdlPjo1jpH5t1pUchGUEVIDYHnnJc/WSjMMUTeR9YwxBo=
X-Received: by 2002:a05:6122:3091:b0:4b2:c554:d2b4 with SMTP id
 cd17-20020a056122309100b004b2c554d2b4mr1938077vkb.22.1701699844565; Mon, 04
 Dec 2023 06:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20231201172212.1813387-12-cmllamas@google.com>
 <20231204115704.40543-1-aliceryhl@google.com> <ZW3goGJBeqTsScI7@google.com>
In-Reply-To: <ZW3goGJBeqTsScI7@google.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 4 Dec 2023 15:23:53 +0100
Message-ID: <CAH5fLgh4S3ByyYp_FohkovMsBPXo6S-0VzowWMFhQBUDNMgTLQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/28] binder: do unlocked work in binder_alloc_new_buf()
To:     Carlos Llamas <cmllamas@google.com>
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 3:22=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
> On Mon, Dec 04, 2023 at 11:57:04AM +0000, 'Alice Ryhl' via kernel-team wr=
ote:
> > You could also write this as:
> >
> >       if (!IS_ERR(buffer)) {
> >               buffer->data_size =3D data_size;
> >               buffer->offsets_size =3D offsets_size;
> >               buffer->extra_buffers_size =3D extra_buffers_size;
> >       }
> >
> >       mutex_unlock(&alloc->mutex);
> >       return buffer;
>
> There is a subsequent patch that adds more work after this and makes the
> goto statement a better fit (patch 19/28)... at least IMO.

Ah, ok. SGTM!

Alice
