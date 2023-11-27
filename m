Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206E27F9F05
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjK0Lxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjK0Lxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226CE191
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701086023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8dFDcEA9Z7jcvOeDtvs4nt1f6dFZbdEOKwzb8RSGdjs=;
        b=hgbicCmJF5CW/KGwtzbaWB4Ua/mOkGjDrECL+uGRCaD/qBQBUpuD4STlc0t7XnddDqirIn
        dyCeq4OrN+2IcMbIck7DwfOuLc4XFqTpdq80qfdBpUbSQh5CuvBQt9tHMNDMMTdWUOrtlt
        eyd+JMiRbyEAUPzRdZF9/QDnFha7l3s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-u37cl6sNMTmcSBXUkFPX1A-1; Mon, 27 Nov 2023 06:53:42 -0500
X-MC-Unique: u37cl6sNMTmcSBXUkFPX1A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a043b44aec3so84879466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701086021; x=1701690821;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dFDcEA9Z7jcvOeDtvs4nt1f6dFZbdEOKwzb8RSGdjs=;
        b=ePjXa8PmgMQBfqSHh+SRA9DW+3CkGhdA3X5lgsOysAdGG59xNz+v14JIx3Mvv6lkRQ
         4ptiotyTHZmo4TrTmPgBnKmvoC3HUxJrv3koONgFf7fvR/zhw6LSGT9Ql7lbL9M4az0k
         QWKY8ifFCnQW3kB9YTIlfQKb5vtOsq3WdftNP7eb9pbemHKL0bMD3cTt02cPuYCc6GYQ
         nlRUMDbQy8b2Gj6/JrqLxYpTfY2I6vuM+/lCvBoQceU3HIQbkQM35vpHnW6WyoE6hgoD
         +VjCpV0OEegj2x7qeslHBKMoopDg01JtsUoqkQPIgpKbIOAXCWW8u2tEt48yKSx0chf8
         F91Q==
X-Gm-Message-State: AOJu0YwrP/rG+l6MyhD/+EyM8V5Iao4+tYZizxIlDN0l0iBPNfo63Odh
        uMG1efpw92oqrcCVglXlqD3BddjjYi6FzYvek93icq6ODUr8PJGbJdSoWsbC6dJB1B21mYzSUCj
        P2B2KcA45f1j+rC9VrZFnem4S
X-Received: by 2002:a17:906:c30c:b0:a04:9f07:cb7 with SMTP id s12-20020a170906c30c00b00a049f070cb7mr7102996ejz.2.1701086020797;
        Mon, 27 Nov 2023 03:53:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMhVv3wMdQRPOR1xkomAIWGJ5bbogBeJn6ZTccLM2kT5Zm2YVoX1QPW5+GpEUs9yK0xrOnuA==
X-Received: by 2002:a17:906:c30c:b0:a04:9f07:cb7 with SMTP id s12-20020a170906c30c00b00a049f070cb7mr7102969ejz.2.1701086020387;
        Mon, 27 Nov 2023 03:53:40 -0800 (PST)
Received: from gerbillo.redhat.com (host-87-11-7-253.retail.telecomitalia.it. [87.11.7.253])
        by smtp.gmail.com with ESMTPSA id bu8-20020a170906a14800b009e505954becsm5617452ejb.107.2023.11.27.03.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 03:53:40 -0800 (PST)
Message-ID: <1cdb1f702ba74e42c09f6f6b6ff2ca223ccca14f.camel@redhat.com>
Subject: Re: [PATCH] net :mana :Add remaining GDMA stats for MANA to ethtool
From:   Paolo Abeni <pabeni@redhat.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Leon Romanovsky <leon@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Shradha Gupta <shradhagupta@microsoft.com>
Date:   Mon, 27 Nov 2023 12:53:38 +0100
In-Reply-To: <1700830950-803-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1700830950-803-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2023-11-24 at 05:02 -0800, Shradha Gupta wrote:
> Extend performance counter stats in 'ethtool -S <interface>'
> for MANA VF to include all GDMA stat counter.
>=20
> Tested-on: Ubuntu22
> Testcases:
> 1. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-Synthetic
> 2. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-SRIOV
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

For the next submission, please remember to include the target tree in
the subj prefix:

https://elixir.bootlin.com/linux/latest/source/Documentation/process/mainta=
iner-netdev.rst#L12

(in this case 'net-next').

No additional actions needed here.

Cheers,

Paolo

