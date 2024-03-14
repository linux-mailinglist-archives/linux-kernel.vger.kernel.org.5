Return-Path: <linux-kernel+bounces-102975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57BB87B957
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F5B1F23DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ED06BB28;
	Thu, 14 Mar 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKSPNiiv"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF192EEC4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405243; cv=none; b=Dn6OwAF3zZeY9c1BR3pWJL3eqk88HOZcDaYH9doQSSb8leaDJLFGjUyXurk13KKq0es+jm2u97EkvrgRFse2X7XpEM6BW3TsBuDaWwIkl5c6OiXrMRzp/eXrR7uSCUtHPnFTwhQluGnMOJibXqeoID38d9ht79zjHyGzdhXrVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405243; c=relaxed/simple;
	bh=N6yjsjWRhgnxpcxjYjr2scRUt+UXkfLo1oL6QkSbVds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/xOCoYZKLVwx9PbT1JXPpnb/WdHbZo7jioj4ryOeUwzNY49c2Ka9geELltKRGDL0dqacAc7cDeLTHwAU0OTAR+KDtx9lj35a9m4ATqYXe/rJLjz9WLt3f+cGa9p0V2N3V2sakjg0ZGGccfbUY6tIg0HCfBIWw/mAa1a0wlmL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKSPNiiv; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5cbc4a585so237548241.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710405241; x=1711010041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6yjsjWRhgnxpcxjYjr2scRUt+UXkfLo1oL6QkSbVds=;
        b=dKSPNiivNxS/2rbhi+4sW8wwRWfd9N1l6z8Y3dZVebEzkzQLXzwgBp6P26cT6SOnac
         iIN1Dff3JQnIU3q3tot03UgedrVGlgl5MrzXx/bC+ICulTazIs/BDKpYkg/Xn028wv7p
         7Pyf6Hen4S7IGFF3MIA47RsFIINMfEmfZJsBmhSZLupzdgwXfYms5KTeCk80Wqjc/CaF
         g6q1j2yebVKBCugJDMJen+dEbPs11G8HPedNFk+Qxia/UkPAJPg/VxOk6aDeNKwcI+R9
         KfHp0A2e6NRVn3x0OPLjAxWq1K6t8hiKdXuvStUbKz+B5bUfdJtGYT/5QswPrV+0zcbo
         JU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710405241; x=1711010041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6yjsjWRhgnxpcxjYjr2scRUt+UXkfLo1oL6QkSbVds=;
        b=DwTXKj83pShtyu8KCEm9Bm+EwKvYCsaZr3rVjMMwTYGJnvEmyK5gpi+L4j2+rfPog0
         rJandKhR28CuHxEmgt8aWrh7nbXyZthwNSFzFgfGr5N6LXfg3hkMou7T+3WAEmdM8CUA
         mILiWICYSfrXk6/gZlye1mLawdtEk4PFU9QFSiT7oA4nrxKW8/bG6y/789OzqRGmT1Dz
         AsBuvOjH95mdztPEnYP8iv/yX9gVi+8QLdxxjESBu+on5NEGTjHPJ15zS/U4QFzL1ujp
         CllRxCP0NqRmz47QL2vUibULj/1KQ0mBIMKH2K3j5WZZ4WrdA3q65cmF+Q4B8gbwwFqj
         GEuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHObRSMi0isUbbWfxY0oGpO8vMPqsYzkYhUx3QrJZlEIQHvNvbr/DtMFaW1cnlDheBDQrpN/rwmv05SIg32MAkTUYDpzp2nO6O6ywK
X-Gm-Message-State: AOJu0Yzlr5igas+26/bKgL4uGrd8xvYvKuSsHkcAvNIUvAHqg8Ld5Ew2
	vnUTK43Io8N+a9J35p0jVFuyBt1vQl7nUO7HBHYdvoP1GmrMpqVMfW0VQhOveaHbAZp+c9rU90K
	kC0KGfGgB7emZOkBG3NnvgpZiSdE4JDD7PZ23
X-Google-Smtp-Source: AGHT+IHHrs1YhkiRJDbYJkbFBUUIFoHFGu6iB4NuQvWKi1Ez35d77ryeACAsn+odYILKmOK2/WEr/UsZfJEq+YYgAwk=
X-Received: by 2002:a67:f707:0:b0:474:cfeb:de2b with SMTP id
 m7-20020a67f707000000b00474cfebde2bmr1059323vso.25.1710405240635; Thu, 14 Mar
 2024 01:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302140058.1527765-1-dzm91@hust.edu.cn> <26730f76-871d-4a6d-8b16-ea3e52ef5357@loongson.cn>
 <421183dd-73d4-43b1-bfb3-f7c7db7d82cb@hust.edu.cn>
In-Reply-To: <421183dd-73d4-43b1-bfb3-f7c7db7d82cb@hust.edu.cn>
From: Marco Elver <elver@google.com>
Date: Thu, 14 Mar 2024 09:33:23 +0100
Message-ID: <CANpmjNNdHpoiYZNg1PFjxetJGGwjNQ8=LrZO4AS3M7Azfp+raQ@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Add dev-tools/ubsan Chinese translation
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Yanteng Si <siyanteng@loongson.cn>, Alex Shi <alexs@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCAxNCBNYXIgMjAyNCBhdCAwNjo1OSwgRG9uZ2xpYW5nIE11IDxkem05MUBodXN0LmVk
dS5jbj4gd3JvdGU6DQo+DQo+IHBpbmc/DQoNCitDYyBLZWVzDQoNCj4gT24gMjAyNC8zLzYgMTc6
MTUsIFlhbnRlbmcgU2kgd3JvdGU6DQo+ID4NCj4gPiDlnKggMjAyNC8zLzIgMjI6MDAsIERvbmds
aWFuZyBNdSDlhpnpgZM6DQo+ID4+IFRyYW5zbGF0ZSBkZXYtdG9vbHMvdWJzYW4ucnN0IGludG8g
Q2hpbmVzZSwgYWRkIGl0IGludG8NCj4gPj4gemhfQ04vZGV2LXRvb2xzL2luZGV4LnJzdC4NCj4g
Pj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRG9uZ2xpYW5nIE11IDxkem05MUBodXN0LmVkdS5jbj4N
Cj4gPg0KPiA+IFJldmlld2VkLWJ5OiBZYW50ZW5nIFNpIDxzaXlhbnRlbmdAbG9vbmdzb24uY24+
DQo+ID4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPg0KPiA+IFlhbnRlbmcNCj4gPg0KPiA+PiAtLS0N
Cj4gPj4gICAuLi4vdHJhbnNsYXRpb25zL3poX0NOL2Rldi10b29scy9pbmRleC5yc3QgICAgfCAg
MiArLQ0KPiA+PiAgIC4uLi90cmFuc2xhdGlvbnMvemhfQ04vZGV2LXRvb2xzL3Vic2FuLnJzdCAg
ICB8IDkxICsrKysrKysrKysrKysrKysrKysNCj4gPj4gICAyIGZpbGVzIGNoYW5nZWQsIDkyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4g
Pj4gRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vZGV2LXRvb2xzL3Vic2FuLnJzdA0K
PiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04v
ZGV2LXRvb2xzL2luZGV4LnJzdA0KPiA+PiBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3po
X0NOL2Rldi10b29scy9pbmRleC5yc3QNCj4gPj4gaW5kZXggYzJkYjNlNTY2YjFiLi5jNDQ2M2Yw
NzUwZjAgMTAwNjQ0DQo+ID4+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L2Rldi10b29scy9pbmRleC5yc3QNCj4gPj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04vZGV2LXRvb2xzL2luZGV4LnJzdA0KPiA+PiBAQCAtMjIsMTMgKzIyLDEzIEBADQo+
ID4+IERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2Rldi10b29scy90ZXN0aW5nLW92
ZXJ2aWV3LnJzdA0KPiA+PiAgICAgIHNwYXJzZQ0KPiA+PiAgICAgIGdjb3YNCj4gPj4gICAgICBr
YXNhbg0KPiA+PiArICAgdWJzYW4NCj4gPj4gICAgICBnZGIta2VybmVsLWRlYnVnZ2luZw0KPiA+
Pg0KPiA+PiAgIFRvZG9saXN0Og0KPiA+Pg0KPiA+PiAgICAtIGNvY2NpbmVsbGUNCj4gPj4gICAg
LSBrY292DQo+ID4+IC0gLSB1YnNhbg0KPiA+PiAgICAtIGttZW1sZWFrDQo+ID4+ICAgIC0ga2Nz
YW4NCj4gPj4gICAgLSBrZmVuY2UNCj4gPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJh
bnNsYXRpb25zL3poX0NOL2Rldi10b29scy91YnNhbi5yc3QNCj4gPj4gYi9Eb2N1bWVudGF0aW9u
L3RyYW5zbGF0aW9ucy96aF9DTi9kZXYtdG9vbHMvdWJzYW4ucnN0DQo+ID4+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+ID4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMjQ4NzY5NmIzNzcyDQo+ID4+IC0t
LSAvZGV2L251bGwNCj4gPj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04v
ZGV2LXRvb2xzL3Vic2FuLnJzdA0KPiA+PiBAQCAtMCwwICsxLDkxIEBADQo+ID4+ICsuLiBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+PiArDQo+ID4+ICsuLiBpbmNsdWRlOjog
Li4vZGlzY2xhaW1lci16aF9DTi5yc3QNCj4gPj4gKw0KPiA+PiArOk9yaWdpbmFsOiBEb2N1bWVu
dGF0aW9uL2Rldi10b29scy91YnNhbi5yc3QNCj4gPj4gKzpUcmFuc2xhdG9yOiBEb25nbGlhbmcg
TXUgPGR6bTkxQGh1c3QuZWR1LmNuPg0KPiA+PiArDQo+ID4+ICvmnKrlrprkuYnooYzkuLrmtojm
r5LliYIgLSBVQlNBTg0KPiA+PiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQo+ID4+ICsNCj4gPj4gK1VCU0FO5piv5LiA56eN5Yqo5oCB5pyq5a6a5LmJ6KGM5Li65qOA5p+l
5bel5YW344CCDQo+ID4+ICsNCj4gPj4gK1VCU0FO5L2/55So57yW6K+R5pe25o+S5qGp5o2V5o2J
5pyq5a6a5LmJ6KGM5Li644CC57yW6K+R5Zmo5Zyo5Y+v6IO95a+86Ie05pyq5a6a5LmJ6KGM5Li6
55qE5pON5L2c5YmN5o+S5YWl54m55a6aDQo+ID4+DQo+ID4+ICvmo4DmtYvku6PnoIHjgILlpoLm
npzmo4Dmn6XlpLHotKXvvIzljbPmo4DmtYvliLDmnKrlrprkuYnooYzkuLrvvIxfX3Vic2FuX2hh
bmRsZV8qDQo+ID4+IOWHveaVsOWwhuiiq+iwg+eUqOaJk+WNsA0KPiA+PiAr6ZSZ6K+v5L+h5oGv
44CCDQo+ID4+ICsNCj4gPj4gK0dDQ+iHqjQuOS54IFsxX10g77yI6K+m6KeBIGBgLWZzYW5pdGl6
ZT11bmRlZmluZWRgYA0KPiA+PiDpgInpobnlj4rlhbblrZDpgInpobnvvInniYjmnKzlkI7lvJXl
haXov5kNCj4gPj4gK+S4gOeJueaAp+OAgkdDQyA1Lngg54mI5pys5a6e546w5LqG5pu05aSa5qOA
5p+l5ZmoIFsyX13jgIINCj4gPj4gKw0KPiA+PiAr5oql5ZGK5qC35L6LDQo+ID4+ICstLS0tLS0t
LS0tLS0tLQ0KPiA+PiArDQo+ID4+ICs6Og0KPiA+PiArDQo+ID4+ICsNCj4gPj4gPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCj4gPj4gKyAgICAgVUJTQU46IFVuZGVmaW5lZCBiZWhhdmlvdXIgaW4g
Li4vaW5jbHVkZS9saW51eC9iaXRvcHMuaDoxMTA6MzMNCj4gPj4gKyAgICAgc2hpZnQgZXhwb25l
bnQgMzIgaXMgdG8gbGFyZ2UgZm9yIDMyLWJpdCB0eXBlICd1bnNpZ25lZCBpbnQnDQo+ID4+ICsg
ICAgIENQVTogMCBQSUQ6IDAgQ29tbTogc3dhcHBlciBOb3QgdGFpbnRlZCA0LjQuMC1yYzErICMy
Ng0KPiA+PiArICAgICAgMDAwMDAwMDAwMDAwMDAwMCBmZmZmZmZmZjgyNDAzY2M4IGZmZmZmZmZm
ODE1ZTZjZDYNCj4gPj4gMDAwMDAwMDAwMDAwMDAwMQ0KPiA+PiArICAgICAgZmZmZmZmZmY4MjQw
M2NmOCBmZmZmZmZmZjgyNDAzY2UwIGZmZmZmZmZmODE2M2E1ZWQNCj4gPj4gMDAwMDAwMDAwMDAw
MDAyMA0KPiA+PiArICAgICAgZmZmZmZmZmY4MjQwM2Q3OCBmZmZmZmZmZjgxNjNhYzJiIGZmZmZm
ZmZmODE1ZjAwMDENCj4gPj4gMDAwMDAwMDAwMDAwMDAwMg0KPiA+PiArICAgICBDYWxsIFRyYWNl
Og0KPiA+PiArICAgICAgWzxmZmZmZmZmZjgxNWU2Y2Q2Pl0gZHVtcF9zdGFjaysweDQ1LzB4NWYN
Cj4gPj4gKyAgICAgIFs8ZmZmZmZmZmY4MTYzYTVlZD5dIHVic2FuX2VwaWxvZ3VlKzB4ZC8weDQw
DQo+ID4+ICsgICAgICBbPGZmZmZmZmZmODE2M2FjMmI+XQ0KPiA+PiBfX3Vic2FuX2hhbmRsZV9z
aGlmdF9vdXRfb2ZfYm91bmRzKzB4ZWIvMHgxMzANCj4gPj4gKyAgICAgIFs8ZmZmZmZmZmY4MTVm
MDAwMT5dID8gcmFkaXhfdHJlZV9nYW5nX2xvb2t1cF9zbG90KzB4NTEvMHgxNTANCj4gPj4gKyAg
ICAgIFs8ZmZmZmZmZmY4MTczYzU4Nj5dIF9taXhfcG9vbF9ieXRlcysweDFlNi8weDQ4MA0KPiA+
PiArICAgICAgWzxmZmZmZmZmZjgzMTA1NjUzPl0gPyBkbWlfd2Fsa19lYXJseSsweDQ4LzB4NWMN
Cj4gPj4gKyAgICAgIFs8ZmZmZmZmZmY4MTczYzg4MT5dIGFkZF9kZXZpY2VfcmFuZG9tbmVzcysw
eDYxLzB4MTMwDQo+ID4+ICsgICAgICBbPGZmZmZmZmZmODMxMDViMzU+XSA/IGRtaV9zYXZlX29u
ZV9kZXZpY2UrMHhhYS8weGFhDQo+ID4+ICsgICAgICBbPGZmZmZmZmZmODMxMDU2NTM+XSBkbWlf
d2Fsa19lYXJseSsweDQ4LzB4NWMNCj4gPj4gKyAgICAgIFs8ZmZmZmZmZmY4MzEwNjZhZT5dIGRt
aV9zY2FuX21hY2hpbmUrMHgyNzgvMHg0YjQNCj4gPj4gKyAgICAgIFs8ZmZmZmZmZmY4MTExZDU4
YT5dID8gdnByaW50a19kZWZhdWx0KzB4MWEvMHgyMA0KPiA+PiArICAgICAgWzxmZmZmZmZmZjgz
MGFkMTIwPl0gPyBlYXJseV9pZHRfaGFuZGxlcl9hcnJheSsweDEyMC8weDEyMA0KPiA+PiArICAg
ICAgWzxmZmZmZmZmZjgzMGIyMjQwPl0gc2V0dXBfYXJjaCsweDQwNS8weGMyYw0KPiA+PiArICAg
ICAgWzxmZmZmZmZmZjgzMGFkMTIwPl0gPyBlYXJseV9pZHRfaGFuZGxlcl9hcnJheSsweDEyMC8w
eDEyMA0KPiA+PiArICAgICAgWzxmZmZmZmZmZjgzMGFlMDUzPl0gc3RhcnRfa2VybmVsKzB4ODMv
MHg0OWENCj4gPj4gKyAgICAgIFs8ZmZmZmZmZmY4MzBhZDEyMD5dID8gZWFybHlfaWR0X2hhbmRs
ZXJfYXJyYXkrMHgxMjAvMHgxMjANCj4gPj4gKyAgICAgIFs8ZmZmZmZmZmY4MzBhZDM4Nj5dIHg4
Nl82NF9zdGFydF9yZXNlcnZhdGlvbnMrMHgyYS8weDJjDQo+ID4+ICsgICAgICBbPGZmZmZmZmZm
ODMwYWQ0ZjM+XSB4ODZfNjRfc3RhcnRfa2VybmVsKzB4MTZiLzB4MTdhDQo+ID4+ICsNCj4gPj4g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPj4gKw0KPiA+PiAr55So5rOVDQo+ID4+ICstLS0t
LQ0KPiA+PiArDQo+ID4+ICvkvb/nlKjlpoLkuIvlhoXmoLjphY3nva7lkK/nlKhVQlNBTjo6DQo+
ID4+ICsNCj4gPj4gKyAgICBDT05GSUdfVUJTQU49eQ0KPiA+PiArDQo+ID4+ICvkvb/nlKjlpoLk
uIvlhoXmoLjphY3nva7mo4Dmn6XmlbTkuKrlhoXmoLg6Og0KPiA+PiArDQo+ID4+ICsgICAgICAg
IENPTkZJR19VQlNBTl9TQU5JVElaRV9BTEw9eQ0KPiA+PiArDQo+ID4+ICvkuLrkuoblnKjnibnl
rprmlofku7bmiJbnm67lvZXlkK/liqjku6PnoIHmj5LmoanvvIzpnIDopoHlnKjnm7jlupTnmoTl
hoXmoLhNYWtlZmlsZeS4rea3u+WKoOS4gOihjOexu+S8vOWGheWuuToNCj4gPj4NCj4gPj4gKw0K
PiA+PiArLSDljZXmlofku7bvvIjlpoJtYWluLm/vvIk6Og0KPiA+PiArDQo+ID4+ICsgICAgVUJT
QU5fU0FOSVRJWkVfbWFpbi5vIDo9IHkNCj4gPj4gKw0KPiA+PiArLSDkuIDkuKrnm67lvZXkuK3n
moTmiYDmnInmlofku7Y6Og0KPiA+PiArDQo+ID4+ICsgICAgVUJTQU5fU0FOSVRJWkUgOj0geQ0K
PiA+PiArDQo+ID4+ICvljbPkvb/orr7nva7kuoZgYENPTkZJR19VQlNBTl9TQU5JVElaRV9BTEw9
eWBg77yM5Li65LqG6YG/5YWN5paH5Lu26KKr5o+S5qGp77yM5Y+v5L2/55SoOjoNCj4gPj4gKw0K
PiA+PiArICBVQlNBTl9TQU5JVElaRV9tYWluLm8gOj0gbg0KPiA+PiArDQo+ID4+ICvkuI46Og0K
PiA+PiArDQo+ID4+ICsgIFVCU0FOX1NBTklUSVpFIDo9IG4NCj4gPj4gKw0KPiA+PiAr5pyq5a+5
6b2Q55qE5YaF5a2Y6K6/6Zeu5qOA5rWL5Y+v6YCa6L+H5byA5ZCv54us56uL6YCJ6aG5IC0gQ09O
RklHX1VCU0FOX0FMSUdOTUVOVCDmo4DmtYvjgIINCj4gPj4gK+ivpemAiemhueWcqOaUr+aMgeac
quWvuem9kOiuv+mXrueahOaetuaehOS4iihDT05GSUdfSEFWRV9FRkZJQ0lFTlRfVU5BTElHTkVE
X0FDQ0VTUz15KQ0KPiA+Pg0KPiA+PiAr6buY6K6k5Li65YWz6Zet44CC6K+l6YCJ6aG55LuN5Y+v
6YCa6L+H5YaF5qC46YWN572u5ZCv55So77yM5L2G5a6D5bCG5Lqn55Sf5aSn6YeP55qEVUJTQU7m
iqXlkYrjgIINCj4gPj4gKw0KPiA+PiAr5Y+C6ICD5paH54yuDQo+ID4+ICstLS0tLS0tLS0tDQo+
ID4+ICsNCj4gPj4gKy4uIF8xOg0KPiA+PiBodHRwczovL2djYy5nbnUub3JnL29ubGluZWRvY3Mv
Z2NjLTQuOS4wL2djYy9EZWJ1Z2dpbmctT3B0aW9ucy5odG1sDQo+ID4+ICsuLiBfMjogaHR0cHM6
Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2djYy9EZWJ1Z2dpbmctT3B0aW9ucy5odG1sDQo+ID4+
ICsuLiBfMzogaHR0cHM6Ly9jbGFuZy5sbHZtLm9yZy9kb2NzL1VuZGVmaW5lZEJlaGF2aW9yU2Fu
aXRpemVyLmh0bWwNCj4gPj4gLS0NCj4gPj4gMi4zOS4yDQo+ID4+DQo+ID4+DQo+DQo+DQo=

