Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911F67DA119
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjJ0S6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjJ0S6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:58:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4A8B0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:58:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b20a48522fso2385835b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698433093; x=1699037893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=io60u5zI7m0Nkr3gj8hgI941efp/GEK5u/DAlokh5+w=;
        b=Zo94ea7GVN4wu4wrBHBGUy8iV8zaO4ktTT396YlFz7KYjAObsjds2ol+JXMYCUi0HW
         PHS9cZlfm4tSF4Lj/DIvX0+YHTGuXQxhQ7Ahwcgk5PVssdUu6aTcK493l88KkVQQD71S
         Kr+HwrA2BXUwz2LzPXH41vCrrjw73xQBzATebJu9v5/1z/lugr4PHfsx/1hzZYrF5J6Z
         8Xm8UQZLWv0SkeRuK0G7z4qOLOP5mawHfB3C7AkswKcCHYEl1mnIl4aiUgrJUQ9YL147
         qNMXnDuuMn/ukeIpa9u0pC0TKCv0H025qRhGl4utJg6yq3UdL1jOViOPMxif+gyO0ssa
         efjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698433093; x=1699037893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io60u5zI7m0Nkr3gj8hgI941efp/GEK5u/DAlokh5+w=;
        b=IscUuI5+bTBCR9FGA+/TwOQZRwSg7iqTfm/OWNpapUYXHT950QpsYV3UzYZsFB5Tgx
         PSh+WqaM4siWl864udh+Wh9geErT9dBpuc9CYaN3i+PKsFduW/IncrcLlYm2smZ4Eunf
         KW+nItMMnzWZx7TK+XxIYQmmQ8ERPL6jkoTgk6fnIlE/HYBx0fpNnZzdGYiVWMMBsBV0
         upHeUvtd74aMLgO1pE2g+q3lRNCshP/BQbucdOr50wb1SKCAPFMGPOt7ZVzlbwCyDzVj
         isPNcfLDlz6sWfOrXYamxXk3RIWjNW//vo+/BGVqSUoYfQDU0gMpbInGfw9BbeScGagV
         /y8w==
X-Gm-Message-State: AOJu0YwkCwFw5dVqaH5OkjZM1hS+vcXez4krU9D6tS3js5a3PH+3JiG4
        XVeU4L9pI0OYgvV+GX177Q3kbg==
X-Google-Smtp-Source: AGHT+IGCPLUCPTvK3wDC4poaY6S2aDztJvRixDKQ94OoXzFXeb/m2AdASuHwWgsRzq03EKYBlvHTkQ==
X-Received: by 2002:a05:6a20:a206:b0:174:d189:2f93 with SMTP id u6-20020a056a20a20600b00174d1892f93mr3078602pzk.59.1698433092818;
        Fri, 27 Oct 2023 11:58:12 -0700 (PDT)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id s11-20020a056a00178b00b006bc3e8f58besm1728698pfg.56.2023.10.27.11.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 11:58:12 -0700 (PDT)
Date:   Fri, 27 Oct 2023 11:58:10 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] riscv: Script to autogenerate instruction handling code
Message-ID: <ZTwIQsJh0VWyAn61@ghost>
References: <ZRD8RzBeA2RMrcki@ghost>
 <20231023-aa3f789ccb483afbbdd55b38@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-aa3f789ccb483afbbdd55b38@orel>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:19:23AM +0200, Andrew Jones wrote:
> On Sun, Sep 24, 2023 at 08:19:35PM -0700, Charlie Jenkins wrote:
> > I have heeded Andrew Jones' advice and written a script to generate the
> > instruction handling code. It is still in development, but currently
> > lives on a fork of riscv-opcodes [1]. I am interested if what I have
> > produced so far is in line with what people would want to see.
> 
> Hi Charlie,
> 
> Sorry for my slow response. I'm glad to see that we're going in a
> direction where we generate these functions and reuse an existing
> generator to do it.
> 
> > 
> > An insn.h file can be generated by running the following in the repo:
> > 
> > make
> > python3 parse_linux.py instr_dict.yaml insn.h opcodes_config variable_field_data.yaml
> > 
> > I have pushed the generated files to the repo so people do not need to
> > run the script.
> 
> I couldn't find the generated files, not even [3] from your references
> seems to be present.
> 

I somehow deleted the files... I have added them back:
https://github.com/charlie-rivos/riscv-opcodes/blob/linux_parsing/insn.h
https://github.com/charlie-rivos/riscv-opcodes/blob/linux_parsing/opcodes_config

> > 
> > Each instruction has "variable fields" such as registers and immediates.
> > For each variable field that appears in any provided instruction 3 functions
> > are provided: extract a variable field from an instruction, insert a value into
> > a variable field of an instruction, update a value into a variable field of an
> > instruction. Update first clears the previous value of the variable field of the
> > instruction. Then for each instruction, the script generates a function to check if an
> > arbitrary 32-bit value matches the given instruction, and a function to
> > generate the binary for the instruction given the required variable
> > fields.
> > 
> > I was able to use riscv-opcodes to parse the instruction files, but
> > needed to create a new data structure in variable_field_data.py [2] which
> > holds the positioning of immediates inside of an instruction.
> > 
> > I envision that opcodes_config [3] would live inside of the kernel alongside
> > a simple script to call riscv-opcodes (that resides somewhere in the
> > user's file system) with appropriate parameters. When somebody wants to
> > add a new instruction, they can add an instruction to opcodes_config,
> > run the script, and commit the resulting generated file.
> 
> That sounds good to me. (They may hand craft the functions for a single
> instruction too, by just using the other functions as templates, but even
> if the script isn't used all the time in the future, the initial
> conversion of many instructions makes it worth while, IMO.)
> 
> > 
> > If this script is in a direction that people like, I will continue to
> > fix up the issues in it and try to get it upstreamed to riscv-opcodes
> > before I send a kernel patch.
> 
> Please send me a pointer to opcodes_config and insn.h. Also, since you're
> extending riscv-opcodes with variable_field_data.py, have you found a way
> to verify that all the immediate offsets are correct? Or were the offsets
> extracted from the spec/tool directly somehow? I.e. was
> variable_field_data.py mostly generated itself?
> 
> Thanks,
> drew

No, they were hand-coded unfortunately. riscv-opcodes invented a whole
bunch of names for different styles of immediates. How I did it manually
was find an instruction that used that immediate type, then go to the
spec and figure out the bounds of the immediate. There are some further
complications like some immediates can't be specific value (normally 0)
and some immediates are split. I don't think it's worth the effort to
auto-generate that.

Recently I have been distracted from this, but I have re-evaluated this.
I believe it might be better to not store the Linux parsing scripts
directly in riscv-opcodes, but rather generalize the scripts in
riscv-opcodes and provide it as a Python package. I have a prototype of
this working, but it is still a work in progress. I would like to avoid
using the parse script already in riscv-opcodes so the python package can
be fully contained inside of the repo, and the parse script can remain
separate. However, there are some features I would like to add to the
parsing so I would need to add those features to parse.py first.

- Charlie

> 
> > 
> > - Charlie
> > 
> > [1] https://github.com/charlie-rivos/riscv-opcodes/tree/linux_parsing
> > [2] https://github.com/charlie-rivos/riscv-opcodes/blob/linux_parsing/variable_field_data.py
> > [3] https://github.com/charlie-rivos/riscv-opcodes/blob/linux_parsing/opcodes_config
