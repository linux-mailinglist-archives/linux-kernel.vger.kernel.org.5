Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6302E7A12E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 03:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjIOBYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 21:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjIOBYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:24:46 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176EE2708
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:24:42 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41513d2cca7so156491cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694741081; x=1695345881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74CtxUCIYHKHg9tWUr4iQH71rMCgTYq33VCTDKT+9KU=;
        b=SnYJtr+lnAINHypdcPq/d/if5PcWVnEjwBp+G8vsN2bjy59rTNel9a9GI5EoaRBW9n
         Rvukc3AP/SP8ikfd9vRaEzhUuDZ/9bObHjxXSknIr6D5mIK19zeUkkqip9PGW5i5ex3c
         7hemnDRVuqHwis1y0zfG59uVsulZNq3MiFrNgVgOGDDKiG5rMfss3+9IQ2BdV7VGDCwg
         TdAqEqSlXGzz4CLwHrFHmryDGcAonRp2oSBLc1xfi4SYDnWdUSwB+AS0cxtacRFwJy0Z
         aMaU4mbYT+AVRWuE4lX5GKNZih2a6GROvO9Xy7lXWxHjkW1GWlWmxZ1MMcoU/at1AVSl
         AEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694741081; x=1695345881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74CtxUCIYHKHg9tWUr4iQH71rMCgTYq33VCTDKT+9KU=;
        b=U+VfFku8cxmuzNq9zKuBxCsARxGSLzgH6kuhepriTO0AfAHBvWGZx0qgc6II+OchlF
         fW9eeNS7iIrHcNp6gylrdNrU9fUknn9JtD5rLIaScMs3xLK5pv48MIEURw4INyrw/EO0
         qMWZ0xEth5wV6O/Rh2Pa7GeX5+uQ71+qyy+pug6TCgvcpwu2mBw6jjOLAvjZ6cEAIFKD
         5nXkSGrBawFfFwJ8JOUi3QbY2whfH49wRYbgnqQc0nRlxqxs2vzwC+u/5V7xJ2ZbVkHu
         TRSFWSktZnQl9f1W4dqvSn0tJ1bSWxvBqzRKRF5fUGO7hikkYuY8/t/cjnGE7qCCWJTE
         EX/Q==
X-Gm-Message-State: AOJu0Yzv0oNX8K1zeEy/aUgqNxvz+Fa/O5TLKdGL/udwDdbtJaSB5QPJ
        lGZp5lnNpsTwMeuYXql3cLrSusCAA1S+P3sVBKpwDA==
X-Google-Smtp-Source: AGHT+IGFwUSKsgWRp7QDr28sTxEcIygWw9HdJsiUKYG75UfmKQUC0mX+HXPSLwhkIeiL3CIYCl7XZdzp0KHoRjzRn9Q=
X-Received: by 2002:a05:622a:13c7:b0:410:8ba3:21c7 with SMTP id
 p7-20020a05622a13c700b004108ba321c7mr160183qtk.18.1694741081098; Thu, 14 Sep
 2023 18:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230914182922.27157-1-quic_kriskura@quicinc.com>
In-Reply-To: <20230914182922.27157-1-quic_kriskura@quicinc.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Thu, 14 Sep 2023 18:24:30 -0700
Message-ID: <CANP3RGeMFnBdQ3yS3i_QqWCuQB34Ma8ToEnfH-WjZQBeNgqoFw@mail.gmail.com>
Subject: Re: [RFC] usb: gadget: ncm: Handle decoding of multiple NTB's in
 unwrap call
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

The casts should probably use the actual correct ptr type instead of void*

Feels like this should go to stable@
