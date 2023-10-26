Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17737D7D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjJZHXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZHXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0BDD6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698304932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZJkB38/zw4XAEeeCL9Roq4pYoTYCFvhY7CDxbqwXS0=;
        b=AiunzlF0s2HMU1sz+dFgNkYX7IvZgc81ZEgxHKYSC/i/7e9p2dLzXZUFrXYDujlDwyKWhJ
        2RrbTuch1TSYWGiblfXr6O4iWmA/k6pyUtgTCRs8skl69mMjqjkWXt6aQLqFAQJyyPuhWU
        Jl6xE9Q6S/MqefSdRYAa48prGgbfurw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-PCy0OLxqMTmz6zD5iFq6UQ-1; Thu, 26 Oct 2023 03:22:10 -0400
X-MC-Unique: PCy0OLxqMTmz6zD5iFq6UQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c45a6a8832so1808166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698304929; x=1698909729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZJkB38/zw4XAEeeCL9Roq4pYoTYCFvhY7CDxbqwXS0=;
        b=UR/YVW6wRPlnFA5LvErDDuZICfDvTc/am7xJ/jWB2TlDG3adFY0ZrpLtZ8J4uaPiF0
         ANUQYQFV+xDywzqKEee662Mud9PbCKCKFvA7k3h3HqKywI9fLWqm4FnbYWJHwRyXutCj
         wyngExewjGWtgGle8wz/Q97DbTs3qCG5Zzh/AxcIEOH8eUwcApSFW7B13YXTi3emeKaF
         UKYZXyZEPU9cnVl3c8Op3lGW2QUKue5Z0EsrYRubr0a/aYZj4EhdhShdR5yooKiGemQI
         4O5O0hmIQtXSWb3xXidraLPijXr7ic6NY5+kTg/lHD/ZoGeC1Mm6rxW/5S8Okv025Fn8
         NEDQ==
X-Gm-Message-State: AOJu0YzlbIdHLWTM87ORLYWIwGSG7iFHKjKlRw+/jgdiFQNiTWpuYAXr
        Nay5E+DSxOQJ5tUw69zQ2v+V3wRPCLx9dcHH0hkIuOLGbAJsTBm5Y0OTWa9lgQd5IE/z05YcYCT
        cnOobw6k7uRpRxkqQKKHzKfcPOOtrBy/9
X-Received: by 2002:a17:906:6d8f:b0:9c9:603c:407e with SMTP id h15-20020a1709066d8f00b009c9603c407emr8068035ejt.0.1698304929381;
        Thu, 26 Oct 2023 00:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiqm3J1X0mq1YRAUrKSxwrYawpgs3wu4cuGHSmjF2OVu9Mp1a/tpcR0y8zIaFQ4jGcVwc1RA==
X-Received: by 2002:a17:906:6d8f:b0:9c9:603c:407e with SMTP id h15-20020a1709066d8f00b009c9603c407emr8068018ejt.0.1698304929028;
        Thu, 26 Oct 2023 00:22:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-52.dyn.eolo.it. [146.241.245.52])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm11040909ejc.154.2023.10.26.00.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:22:08 -0700 (PDT)
Message-ID: <5436a58dc63d7e7cc2cb2fbda722f0c0406e88bf.camel@redhat.com>
Subject: Re: [PATCH] Fix termination state for idr_for_each_entry_ul()
From:   Paolo Abeni <pabeni@redhat.com>
To:     NeilBrown <neilb@suse.de>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Chris Mi <chrism@mellanox.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 26 Oct 2023 09:22:07 +0200
In-Reply-To: <169810161336.20306.1410058490199370047@noble.neil.brown.name>
References: <169810161336.20306.1410058490199370047@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-24 at 09:53 +1100, NeilBrown wrote:
> The comment for idr_for_each_entry_ul() states
>=20
>   after normal termination @entry is left with the value NULL
>=20
> This is not correct in the case where UINT_MAX has an entry in the idr.
> In that case @entry will be non-NULL after termination.
> No current code depends on the documentation being correct, but to
> save future code we should fix it.
>=20
> Also fix idr_for_each_entry_continue_ul().  While this is not documented
> as leaving @entry as NULL, the mellanox driver appears to depend on
> it doing so.  So make that explicit in the documentation as well as in
> the code.
>=20
> Fixes: e33d2b74d805 ("idr: fix overflow case for idr_for_each_entry_ul()"=
)
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Chris Mi <chrism@mellanox.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: NeilBrown <neilb@suse.de>

Since the affected user is in the netdev tree, I think we can take this
patch. But this is also a sort of gray area of the tree... @Matthew are
you ok with that?

Thanks,

Paolo

