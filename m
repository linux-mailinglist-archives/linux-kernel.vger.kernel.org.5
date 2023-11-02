Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F409B7DF4DC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376797AbjKBOYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKBOYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:24:48 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F91182
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:24:42 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41cba6e8e65so5241751cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1698935081; x=1699539881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=varkfJCjnH+u3E50Sky0yjh/elja1DPy2fnutdy0fKI=;
        b=cnNxRUx7ccBQGko5c0vAUqTMzOLY8iG/itkdGwAQNJxxzRx753c2aEE9v2rfl1cmot
         flImMkJQKEaV8c8g+Xy4EQx4pA4C6eel7PCYg2fk200NjECcsFdCsA79w7flqdtARnD6
         gZfrddTQcY+ozR50CJ2IcN6VpIuf/Gfd3CrVaVpyVsU1xFyIRvWjM0oejN/mHjbPSVut
         1BBCjBKLU75Yd8pJ+6FZ0vamtAVDLfMsQrpWX/jcFE5MH1kamac7TxMJHbxdsitcg95v
         E/btemoZytAvN7gKyHjZay4oMKqvQS7yBgyNbkyO6Bpncbi6V0/UwVON9Gigsd/4AuOP
         /vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935081; x=1699539881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=varkfJCjnH+u3E50Sky0yjh/elja1DPy2fnutdy0fKI=;
        b=hOWyIK4zTgoFftSV04okUSRgE7qn85gTTJRWSrwSiZzcN7+rWPTebyX2cT1YzO058d
         z8/lxmuscwW+/sA6WmqeUMONyUuT642rRMKn0jkM16wE/455jYlTti8o6Kyazq5PE5N5
         eHyAJBPyJ0ydNc4hSL/SYMjsFy3xUzb4+m5L8wkDwAQTbdvIcKzCMTDXaAUQtgR+SkAT
         KucqG0cnAPzixsmPskrr0t+pqU2oyQWYeGc1B2OSVKWWnAm6KI6YM0tJLMLRCf0HHOja
         y1JDbimgtAGrUUhqBJAP+VpkuUWS+oJ77fITftT7d9kXNygGqXQXKu0lYzPhqIrrkaDs
         pmNA==
X-Gm-Message-State: AOJu0YxLjYfRgLXDMONCicKBBsfyKvy5cby8RUOQHOnKw3ARNoDZX/sM
        f9MXReRDwfjX28qIuGAjKtL6NKDGBcp++XC8FQ20bQ==
X-Google-Smtp-Source: AGHT+IH0Y68XhZR7psJfRikRrstCfvOIMTxVmiuULLZaDr4XBQoFiKDeDkzTE0NG9ZK0jSv8qPfgX077gTc8xgXgCAA=
X-Received: by 2002:a05:622a:44b:b0:412:3092:feab with SMTP id
 o11-20020a05622a044b00b004123092feabmr21550874qtx.50.1698935081374; Thu, 02
 Nov 2023 07:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <2023110205-enquirer-sponge-4f35@gregkh>
In-Reply-To: <2023110205-enquirer-sponge-4f35@gregkh>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 Nov 2023 10:24:04 -0400
Message-ID: <CA+CK2bDUaQDwgF-Q0vfNzHfXmn-QhnHTSE32_RfttHSGB7O3DA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
        rafael@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
        david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
        bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 1:42=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Nov 01, 2023 at 04:08:16PM -0700, Sourav Panda wrote:
> > Adds a new per-node PageMetadata field to
> > /sys/devices/system/node/nodeN/meminfo
>
> No, this file is already an abuse of sysfs and we need to get rid of it
> (it has multiple values in one file.)  Please do not add to the
> nightmare by adding new values.

Hi Greg,

Today, nodeN/meminfo is a counterpart of /proc/meminfo, they contain
almost identical fields, but show node-wide and system-wide views.

Since per-page metadata is added into /proc/meminfo, it is logical to
add into nodeN/meminfo, some nodes can have more or less struct page
data based on size of the node, and also the way memory is configured,
such as use of vmemamp optimization etc, therefore this information is
useful to users.

I am not aware of any example of where a system-wide field from
/proc/meminfo is represented as a separate sysfs file under node0/. If
nodeN/meminfo is ever broken down into separate files it will affect
all the fields in it the same way with or without per-page metadata

> Also, even if you did want to do this, you didn't document it properly
> in Documentation/ABI/ :(

 The documentation for the fields in nodeN/meminfo is only specified
in  Documentation/filesystems/proc.rst, there is no separate sysfs
Documentation for the fields in this file, we could certainly add
that.

Thank you,
Pasha
