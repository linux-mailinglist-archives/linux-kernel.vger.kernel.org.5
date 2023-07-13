Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC37751D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjGMJah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjGMJae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036A61FDB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689240575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1hJc0ylj68nUplngmJ3wimbvRcnl9hkAT6fZMNYtMxg=;
        b=ZW8PpRFtUn1299zMGOzbHLkhzRkp/k3CRUt+A14ucJrPzlfTe2zEdCT9rr+fDprT54FVzD
        lcpwyzXD21e59EDn4qzF71TfTei3voLwjqL19tTPjfJ3VUEY/IqUhwKluU2+xGJDEp3ThR
        KNgofWJXFYqdkk/3sS42JmPDMGfbpkQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-P4QSj_pkO2G0D4tVr8T9zQ-1; Thu, 13 Jul 2023 05:29:34 -0400
X-MC-Unique: P4QSj_pkO2G0D4tVr8T9zQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-765ad67e690so11911285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689240574; x=1689845374;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hJc0ylj68nUplngmJ3wimbvRcnl9hkAT6fZMNYtMxg=;
        b=UOdcU79FnOPDdg45eNchBcMjqy5tt2dQR1JqrvacRBQ1Jq07i9cjcb/uV3fSKSDcRT
         9ZBttQNdV+cYHRBYBsSjHBfvXC5UdjzLhrtWAMWOlgJyFx4/Iu9XendK10ce+YMicXa6
         1C4zYfPM0Gsdpq/lAp9ZjdsTbdMIV5GEXbD6Oe9T94bi+k5zxr7dnHPCBSPQs3hSJoGE
         XthCsqonFYCy+oZmhqVU4TnE4IS+OnEk7Mc18N5XjYSXGX8Il2mzEzJcmRgn4vc/j3n9
         x1WwmDpS7JmvSabhVMN4UNpzaSNapk6v8upkQLxPoWfMBp6NNSJTLRKW+01nS+ormhH6
         d8GQ==
X-Gm-Message-State: ABy/qLaBhUBKNX558iOEQ4yW44j4x+xGielNr4F+s8ZVDWAayfCxHUqk
        QAb40cf1iQebVzBnxdF9VoXEmTN1136x2omzIO66PUobgEk5DbNbw6QiX9+UcEcpBehtw50qOX5
        jxYAKExH8uIoOR0M7gN5HlxND
X-Received: by 2002:a05:620a:454a:b0:763:c764:577c with SMTP id u10-20020a05620a454a00b00763c764577cmr1299517qkp.5.1689240573875;
        Thu, 13 Jul 2023 02:29:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFizulmmPkdCmAfUhw4RJImpC+MGvmd2qV4G5//7gideYN9XgOJ3k/66LywFqLg/KxL06YjeQ==
X-Received: by 2002:a05:620a:454a:b0:763:c764:577c with SMTP id u10-20020a05620a454a00b00763c764577cmr1299497qkp.5.1689240573576;
        Thu, 13 Jul 2023 02:29:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id os3-20020a05620a810300b00767d7fa3d05sm2715384qkn.136.2023.07.13.02.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:29:33 -0700 (PDT)
Message-ID: <a9dc336793322d3525280e4f30b2acbd0c88bbf8.camel@redhat.com>
Subject: Re: [PATCH net v1] ath6kl:Fix error checking for
 debugfs_create_dir()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Wang Ming <machel@vivo.com>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Date:   Thu, 13 Jul 2023 11:29:30 +0200
In-Reply-To: <20230713040518.13734-1-machel@vivo.com>
References: <20230713040518.13734-1-machel@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-13 at 12:05 +0800, Wang Ming wrote:
> The debugfs_create_dir() function returns error pointers,
> it never returns NULL. Most incorrect error checks were fixed,
> but the one in ath6kl_debug_init_fs() was forgotten.
>=20
> Fix the remaining error check.
>=20
> Signed-off-by: Wang Ming <machel@vivo.com>
>=20
> Fixes: 9b9a4f2acac2 ("ath6kl: store firmware logs in skbuffs")

The SoB tag should be after the 'Fixes' one and you must avoid empty
lines in between.

(The same applies to your other patch)

Cheers,

Paolo

