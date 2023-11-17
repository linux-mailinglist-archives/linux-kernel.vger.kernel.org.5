Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB627EF39A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346023AbjKQNSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjKQNSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:18:02 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C501D49;
        Fri, 17 Nov 2023 05:17:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700227053; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=L8iWjvSUjcfPEqx47fEnsCGv+o2sCsDagd/2JFpM0bj5wE/MNctVF9Ij7RXOjAWxwCvxO0/SKMsjSGRZ6H1HN8f71PS4gNW8B3+Hr3OGekFL9rmNk2Up/NhGj94e+/q0S1CYxqza1CO0dlddep7UolW+tRzuYQuzd79C/JKBzNI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1700227053; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=msTnUzBkdMrnWPUJZZzkIMxxIFsUva2SdUKhC65U6+A=; 
        b=SUTYepuHUFeW+/lRCVUWHFcygPpaPuCMbljGCGId7+KXVV2F4KXJcEY6sQ4F4LRrTiyj0dmtlMYqYBlPJ8aYnKd8oefbVvRJZXzgNeVmtXUhqcX6vA6W0g+u/NGILw3R4a9G3UF1k39nt9JKyAAexrYCqEFc28e7QjUWq3iBQyY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700227053;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=msTnUzBkdMrnWPUJZZzkIMxxIFsUva2SdUKhC65U6+A=;
        b=QOsUk0Kionx52e2ckSOZlYJGxjhZlNjFAAlgq2t1D7OYalIsfQtkicyrQBaeBMs8
        xPDmnfY8m0jocWqBWW2qiBjV1cCJdd9GcnnBHEGYxRLhqrcCHMjLP0wsEWRM8rqp++s
        qrzVTIWVO8UvAAlbXGvzq7W42gE1x6kYJtPjrFpY=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1700227022146705.98717921503; Fri, 17 Nov 2023 18:47:02 +0530 (IST)
Date:   Fri, 17 Nov 2023 18:47:02 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "davem" <davem@davemloft.net>, "edumazet" <edumazet@google.com>,
        "kuba" <kuba@kernel.org>, "pabeni" <pabeni@redhat.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "netdev" <netdev@vger.kernel.org>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>,
        "syzbot+bbe84a4010eeea00982d" 
        <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
Message-ID: <18bdd6d7d1e.f8bd3007064.1218727710101871071@siddh.me>
In-Reply-To: <bdbb321b-64e4-4e21-bcf8-e1d201f0a5dc@linaro.org>
References: <000000000000cb112e0609b419d3@google.com>
 <7824cf85-178f-4fca-8058-b9a1f49d3113@siddh.me> <bdbb321b-64e4-4e21-bcf8-e1d201f0a5dc@linaro.org>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 18:18:56 +0530, Krzysztof Kozlowski wrote:
> Any checks would need to have proper locking. Or at least barriers...
> Adding checks without locks usually does not solve race conditions.

Yes of course. I just wanted to put whatever I tested out there.

> Other start is proper ref counting, so the structures are not released
> too early. We have several bugs like this in NFC before, so you can take
> a look at their fixes.

Sure.

Thanks,
Siddh
