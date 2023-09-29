Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79ED7B2A50
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 04:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjI2CWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 22:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjI2CWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 22:22:43 -0400
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226E41B2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:22:41 -0700 (PDT)
Received: by mail-oi1-x24a.google.com with SMTP id 5614622812f47-3ae214a02a6so30313926b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695954160; x=1696558960; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQuRf5Op91GMp6I64iOAOXyIxo9VVhezmhdMGR6LDIA=;
        b=Aj+3h1dJriamurT5CdBXeuURZFiJt9SJ/RZTtyKY2aoLo7E0mra+JeE/U0cxEue71F
         fDsCs6wDvoiXrN5Qe98YrLUey70354IHQBcWn/cU2/FgKsRjbwK00cFaIZoQFa3SysGH
         ZNrrz8lX8nZbpXhwow+euDokoU2SC7consV5VxbbVjKzIV8Hbf5L++BbOqNjp/oJrhPe
         UIDN+jv2O4ziOuzaqiQ45Ej53bGIWgYw92FQWTyodMMZn9oIGzgSclKwFDtwXB8nXpNG
         X9/LvtbJHlCX7lg7Aern1dmX32pzcQ8qeLSHeb9LcufoG6/cJMO5145tqwyhTV1XczAG
         YP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695954160; x=1696558960;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQuRf5Op91GMp6I64iOAOXyIxo9VVhezmhdMGR6LDIA=;
        b=juWuf3NWR16owm9ztxRTEINA+vfLHOaozqnh/ELu0Kac+b6gVbd/hM9Nz9/9gKAt0Z
         Y2vSh5TdDnPr6uThvQt3eS2uj1ElmNkSmI6vCBeU+FhGBdOoEiIBv0HvYbhHLNrGeuX2
         InVM0va1eEpCv3ZRq+YTHP0veooAvpWqTn3RxLtRMWX4dphiHtlbIhvNm0HGujQ449Ui
         Edix4Zu4IUHY1JO+IpB0M1zAjjIc/4geAO4eRovVx+p1zRCywwas5OTqHOmvsHAtm8BC
         PblB329FVLL27O3H4kAAyrZuoNtcDLgsDRFgnx++ERVmsuc2MQJwovYuuw8zWZhZPibp
         JSwQ==
X-Gm-Message-State: AOJu0YwjX7XKaF8FczI5zgsK6IZVhXf0Ttu7kLscHBx7TnMzGXZKSy7J
        PAl7GPxn+04idqYkGvOhA97WCVf0EVI=
X-Google-Smtp-Source: AGHT+IGXd++pIhFgrpfD0VhryBP80o+/Kb3L6EDSBqqykBuRhqDzVj4g5FLySg/GxghI8EtVanGuF37DNhU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6808:10cd:b0:3ae:2024:837d with SMTP id
 s13-20020a05680810cd00b003ae2024837dmr1407151ois.8.1695954160448; Thu, 28 Sep
 2023 19:22:40 -0700 (PDT)
Date:   Thu, 28 Sep 2023 19:22:16 -0700
In-Reply-To: <20230928180651.1525674-1-pbonzini@redhat.com>
Mime-Version: 1.0
References: <20230928180651.1525674-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <169595365500.1386813.6579237770749312873.b4-ty@google.com>
Subject: Re: [PATCH gmem FIXUP] kvm: guestmem: do not use a file system
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 14:06:51 -0400, Paolo Bonzini wrote:
> Use a run-of-the-mill anonymous inode, there is nothing useful
> being provided by kvm_gmem_fs.
> 
> 

Applied to kvm-x86 guest_memfd, thanks!

[1/1] kvm: guestmem: do not use a file system
      https://github.com/kvm-x86/linux/commit/0f7e60a5f42a

--
https://github.com/kvm-x86/linux/tree/next
