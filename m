Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7772A7F52E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjKVV64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjKVV6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:58:55 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39B11A5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:58:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-548db776f6cso1080a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700690330; x=1701295130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK1pw28z/HaK2fY8cE0EMmoeTfAqUXqCdbrdN/RymPA=;
        b=pUzFtiWWFZDpZCwS1gIRqq9UphFRB4nDwESEaZw8dP4ThzzHBRN+GYx2MOBeJdBOr/
         YZ1Azvb0AfjBvJ1r7GkCklsxEr8kaikoZSYqwFuOHwP7K3sPiJLJy+qNg5DA4ANfXY6s
         g/XZtf5rX4A+36XL/um4JoY3JSpj3OXi0FdNMkTfDxN3/mkzH1/1FdIHqu/aJKPcSh0W
         actNsoJ4h8TX1CEbdcu0/1d5fElGTtxCocP7HPYAF3gBCVI/ji8GC5jM2fB+T1cF1N+J
         Ed4qj1vu+ZHYtecdy6LR0F39/Accl4+Zr1X9/g3dJcAu59phaXDeoN3Eew4/NVzajvoj
         N+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700690330; x=1701295130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AK1pw28z/HaK2fY8cE0EMmoeTfAqUXqCdbrdN/RymPA=;
        b=CC+UfDdJLukLKe41bXJaLdTtLLXhn5cOS0XUrSNsANKnexf4E3SoVbbDqDPKhPOVxW
         dqiSdpq8JjuDRLW70j/fZKH9Ly5piTu/fBqM9exhZjwhUK0Xz8tN7GGoHAm9Ms1YlWyR
         2kSFlMq2lPzi2rbQg4QksRlbVPnRfUJRJ5FpMpZ56EbBlZzRxMjv7Q8UlLWcmqVpX3Ne
         tmpj0Ps5iFaBDkGfSWuCMrXaupwrkqQ5RIpazdKknrSuHM7n7gk/daYZg/rsRFUwxlNV
         EFDlMKLIuqYQTEUR1HVKGthQCygqa8JRT+ipyXomzDC4+O/mLt29QxhnJKAmi9Nh64sD
         Vi6A==
X-Gm-Message-State: AOJu0YynRl7obKdjK19jEop4JXuGaB6af2rBN9lG/D/k8ZOMinffEjI8
        y4HJYpqcR9lsAy+Cs8Ew0zyv8pn/pUHnjmR5nmQ5Hg==
X-Google-Smtp-Source: AGHT+IERHVdSXfcSI9zAEB8ij5FiDwSSR+1fzQBPD+GC4e+8LIFAScmcdHp/gGoUuBLQleX1qtB4O3DpkYAU4Y2pYdU=
X-Received: by 2002:a05:6402:540a:b0:545:279:d075 with SMTP id
 ev10-20020a056402540a00b005450279d075mr212819edb.1.1700690329979; Wed, 22 Nov
 2023 13:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20231122214447.675768-1-jannh@google.com>
In-Reply-To: <20231122214447.675768-1-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 22 Nov 2023 22:58:13 +0100
Message-ID: <CAG48ez3dn7CAfTmfziBUd_aFfcM1LOYsUuYrKykZAvTv=AAodg@mail.gmail.com>
Subject: Re: [PATCH net] tls: fix NULL deref on tls_sw_splice_eof() with empty record
To:     Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:44=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> syzkaller discovered that if tls_sw_splice_eof() is executed as part of
> sendfile() when the plaintext/ciphertext sk_msg are empty, the send path
> gets confused because the empty ciphertext buffer does not have enough
> space for the encryption overhead. This causes tls_push_record() to go on
> the `split =3D true` path (which is only supposed to be used when interac=
ting
> with an attached BPF program), and then get further confused and hit the
> tls_merge_open_record() path, which then assumes that there must be at
> least one populated buffer element, leading to a NULL deref.

Ah, and in case you're looking for the corresponding syzkaller report,
you can find that at
<https://lore.kernel.org/all/000000000000347a250608e8a4d1@google.com/T/>.
