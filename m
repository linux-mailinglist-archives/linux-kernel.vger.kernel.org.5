Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F8E770201
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjHDNkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjHDNkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:40:00 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4B358D;
        Fri,  4 Aug 2023 06:39:59 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-579de633419so23065167b3.3;
        Fri, 04 Aug 2023 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691156399; x=1691761199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKVcXAZdZwK3sufoB9LA5I8rIyfDhidHbOtgKASbUkE=;
        b=SDR+3yBPrcTF1L2wNYYH5KaV1xpAofs0eAN3pZdXxtxIw6zsGGfk61CNkSoS4YWaCB
         0opfelr3ejD3/lpiC5B/Fv+Bl4YPu81I+IqDccLYevvdj84zMeQeTP0Fq6VffpOmIMt7
         hlYlRHG2Rmg0ArwqiIwOkS5lxIqXD5xwdQVjdp1EmdELBriZlmGK4tYY5WhYAA/mfpyD
         yrolQjgDwbh9YDu9OrirWy1HJnEXdlWQhWpDEHboF7z7jo/Bdw9ZZySoN6uQqyuREZdQ
         NWtGDT7R61RK2uweF3VsuHq6rceWZqPA0TcIzubIwNa2dmKVtK0wf9OnnBI94fcxAuvM
         ytPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691156399; x=1691761199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKVcXAZdZwK3sufoB9LA5I8rIyfDhidHbOtgKASbUkE=;
        b=GDhLwXiuGfVpUHg2XnOfOfHTYICIDkDmbpFVho/v2oGmZh3+ZMJlB5NE4ddxYzfQrc
         bxIfSOGC3Qf3VVPMf8HEl4S76+ShRBs+9kaNs6ymGbIpHaiyfmd8tnTa7HPsaKK3rw7j
         poaFULOwF+InjL2Uj7rYY+wfeFPLAfcIvV650xaJw7OIHUjIihtadBnONxyzB8Cp2tIT
         vztRMvMoZbzDytycnByelbGuw0RCVdDqLpZpqwUZm36uIe2YbTxxpEc9kb1DHHv6hlce
         0SRAwgwhdNDmZB874RLmF77jgJtMEncY/LD4Pk2O/i+GUnbuGCCQ5mZm8ba2BiLbcovM
         NQmw==
X-Gm-Message-State: AOJu0Yzbc2xAneGEwvJoI6U9RILto1IYhi/sAT5EGsRJu+tOvcUlVfob
        eC7CHArX7rCeRzykZnAi/guwjB95IDNXrApp7vM=
X-Google-Smtp-Source: AGHT+IFGITt7I+1H8tVmRHfHLL4PxsQ+/AdtERSEFGNW0OBThkwBHjGfij5B81qlNwM9Ckg45JK3S6kD6MM7Dmqa72s=
X-Received: by 2002:a0d:ea4a:0:b0:583:b4fe:f9c7 with SMTP id
 t71-20020a0dea4a000000b00583b4fef9c7mr1685078ywe.39.1691156398793; Fri, 04
 Aug 2023 06:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230804114610.179530-1-nmi@metaspace.dk> <20230804114610.179530-4-nmi@metaspace.dk>
In-Reply-To: <20230804114610.179530-4-nmi@metaspace.dk>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 4 Aug 2023 21:39:47 +0800
Message-ID: <CACVXFVMZWPnP+=cdbh-oJpbst-yAjpRGC8meL0V2YwForJJjig@mail.gmail.com>
Subject: Re: [PATCH v11 3/3] ublk: enable zoned storage support
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 8:34=E2=80=AFPM Andreas Hindborg (Samsung)
<nmi@metaspace.dk> wrote:
>
> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> Add zoned storage support to ublk: report_zones and operations:
>  - REQ_OP_ZONE_OPEN
>  - REQ_OP_ZONE_CLOSE
>  - REQ_OP_ZONE_FINISH
>  - REQ_OP_ZONE_RESET
>  - REQ_OP_ZONE_APPEND
>
> The zone append feature uses the `addr` field of `struct ublksrv_io_cmd` =
to
> communicate ALBA back to the kernel. Therefore ublk must be used with the
> user copy feature (UBLK_F_USER_COPY) for zoned storage support to be
> available. Without this feature, ublk will not allow zoned storage suppor=
t.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Ming Lei <ming.lei@redhat.com>

Thanks,
