Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F6F7FBB01
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbjK1NM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344343AbjK1NM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E16D63
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701177151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=qXxb/9aW5dF9T0+/0/0Z8yiaKkAgv6wDXHWvegv7WGI=;
        b=KRMRLjslZ4buaVgS5Qb5n/CssS6KN82nUmNGV4SrvBCxOpK5FIH1vkSciIgK5zrm7WGiIC
        VBW99loFABDC49Qhg6lFy0EasUvGj3rjmWBQpA2MbUjtEZiFsjS6QVCyhzCF+pfiuxrZUu
        m+0QPuB6CoTyfzHpfwOBeZEVwoJpLs0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-4uaBtUmEOF6tRJtoD_ZrBQ-1; Tue, 28 Nov 2023 08:12:29 -0500
X-MC-Unique: 4uaBtUmEOF6tRJtoD_ZrBQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-679ceb85c6cso79606346d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177149; x=1701781949;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXxb/9aW5dF9T0+/0/0Z8yiaKkAgv6wDXHWvegv7WGI=;
        b=gYFS2EBzj6Oqspfwua9AAQ23Mi8BcKhtiAmKpwYxWzQNaY8MSg81W8oK43kfNYGTNr
         zkKc8+4SF4Fj05dhbEo1cCYauGXpeGWMTo4wg2LW5GAt7UtzUn0qe46uFs0ofyeSjqOx
         edKVhpNifFl/oVvUXwT44QV8WjjWbDs5g6jq263H2ZyhUjg6I11/9Q/QMGR1UILZimxj
         Fc8eEOk2zvapkdUkQLhk0p7ZTs/0YMvr3vAbRoFNpyWdTC0hyApiPABBokcz/mHdliq1
         ieOT921TmPNOXBTX/JgttknDYw3xeYOQgiqHZhsoAo8jwc+cjqZGSRBjt6Fa416oKpIB
         JLPw==
X-Gm-Message-State: AOJu0YwxSU05iygd4mA4EeSc1RTibbJ6r/uDymqfX2cpC7cQw60eER70
        XIMdyLifQ0NxKOpNPay2xccEFUOS9AtFw4JbtooIEJBKImEOq4WWbeMvqCcg5dI6PRMXbaX7JgI
        ocfmcM6Rtu7XwBYJvSQaEs7vQZsRB9ChNWasQB7t9JLIJWOKtshbNyi7qr0NhEgKc+yss1BlyKg
        s/S1gAOA==
X-Received: by 2002:a0c:e605:0:b0:67a:1c5d:70c5 with SMTP id z5-20020a0ce605000000b0067a1c5d70c5mr15510096qvm.51.1701177148813;
        Tue, 28 Nov 2023 05:12:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhwLeA3QAWHZn4/cB/3/RUlVLlqRRrnC6QUTwMYyMqk3FZk2smhrubfPC9mUZkQIXyXo0ykw==
X-Received: by 2002:a0c:e605:0:b0:67a:1c5d:70c5 with SMTP id z5-20020a0ce605000000b0067a1c5d70c5mr15510075qvm.51.1701177148595;
        Tue, 28 Nov 2023 05:12:28 -0800 (PST)
Received: from rh (p200300c93f306f0016d68197cd5f6027.dip0.t-ipconnect.de. [2003:c9:3f30:6f00:16d6:8197:cd5f:6027])
        by smtp.gmail.com with ESMTPSA id ph25-20020a0562144a5900b0067a18544c41sm4095166qvb.58.2023.11.28.05.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 05:12:28 -0800 (PST)
Date:   Tue, 28 Nov 2023 14:12:23 +0100 (CET)
From:   Sebastian Ott <sebott@redhat.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: usb hotplug broken on v6.5.12
Message-ID: <2c978ede-5e2f-b630-e126-4c19bd6278dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej,

usb hotplug doesn't work for me running stable kernel v6.5.12 on an AMD
based Thinkpad t495s. Bisect pointed to 7b8ae3c24ef ("xhci: Loosen RPM as
default policy to cover for AMD xHC 1.1") - which is 4baf1218150 upstream.

Reverting that from 6.5.12 fixes the issue for me.
Current upstream rc kernel contains this patch but doesn't show the issue.

Regards,
Sebastian

